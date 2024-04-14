
## Provision a SAML identity provider in the data collection account - this will be 
## used to authenticate sso users into quicksights 
resource "aws_iam_saml_provider" "saml" {
  count = var.enable_sso ? 1 : 0

  name                   = "aws-cudos-sso"
  saml_metadata_document = var.saml_metadata
  tags                   = var.tags

  provider = aws.cost_analysis
}

## Provision a trust policy for the above SAML identity provider 
data "aws_iam_policy_document" "cudos_sso" {
  count = var.enable_sso ? 1 : 0

  statement {
    actions = ["sts:AssumeRoleWithSAML"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_saml_provider.saml[0].arn]
    }

    condition {
      test     = "StringEquals"
      variable = "SAML:aud"
      values   = ["https://signin.aws.amazon.com/saml"]
    }
  }
}

## Provision an IAM policy which will be attached to the IAM role and has the 
## necessary permissions to access quicksight users, whom have authenticated via 
## the SAML identity provider 
data "aws_iam_policy_document" "cudos_sso_permissions" {
  count = var.enable_sso ? 1 : 0

  statement {
    actions   = ["quicksight:CreateReader"]
    effect    = "Allow"
    resources = ["arn:aws:quicksight::${local.cost_analysis_account_id}:user/$${aws:userid}"]
  }
}

## Provision and IAM role to be assumed by the SAML identity provider; this role will
## be used to authenticate users into quicksights 
resource "aws_iam_role" "cudos_sso" {
  count = var.enable_sso ? 1 : 0

  name               = "aws-cudos-sso"
  assume_role_policy = data.aws_iam_policy_document.cudos_sso[0].json
  tags               = var.tags

  inline_policy {
    name   = "quicksight-permissions"
    policy = data.aws_iam_policy_document.cudos_sso_permissions[0].json
  }

  provider = aws.cost_analysis
}

## Provision a bucket used to contain the cudos dashboards - note this
## bucket must be public due to the consuming tterraform module
# tfsec:ignore:aws-s3-enable-bucket-logging
module "dashboard_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.0"

  bucket                  = var.dashbords_bucket_name
  block_public_acls       = true
  block_public_policy     = true
  force_destroy           = true
  ignore_public_acls      = true
  object_ownership        = "ObjectWriter"
  restrict_public_buckets = true
  tags                    = var.tags

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning = {
    enabled = true
  }

  providers = {
    aws = aws.cost_analysis
  }
}

## First we configure the collector to accept the CUR (Cost and Usage Report) from the source account 
# tfsec:ignore:aws-s3-enable-bucket-logging
module "collector" {
  source = "github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-destination?ref=0.2.47"

  # Source account whom will be replicating the CUR data to the collector account
  source_account_ids = [local.management_account_id]
  # Indicates if we should create CUR data in the cost analysis account
  create_cur = false

  providers = {
    aws         = aws.cost_analysis
    aws.useast1 = aws.cost_analysis_us_east_1
  }
}

## Setup the replication from the management account to the collector account 
## to receive the CUR data 
# tfsec:ignore:aws-s3-enable-bucket-logging
# tfsec:ignore:aws-iam-no-policy-wildcards
module "source" {
  source = "github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-source?ref=0.2.47"

  # The destination bucket to repliaction the CUR data to
  destination_bucket_arn = module.collector.cur_bucket_arn

  providers = {
    aws         = aws.management
    aws.useast1 = aws.management_us_east_1
  }
}

## Provision the cloud intelligence dashboards
module "dashboards" {
  source = "github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cid-dashboards?ref=0.2.47"

  stack_name      = var.stack_name_cloud_intelligence
  template_bucket = module.dashboard_bucket.s3_bucket_id

  stack_parameters = {
    "DeployCUDOSDashboard"               = var.enable_cudos_dashboard ? "yes" : "no"
    "DeployCUDOSv5"                      = var.enable_cudos_v5_dashboard ? "yes" : "no"
    "DeployComputeOptimizerDashboard"    = var.enable_compute_optimizer_dashboard ? "yes" : "no"
    "DeployCostIntelligenceDashboard"    = var.enable_cost_intelligence_dashboard ? "yes" : "no"
    "DeployKPIDashboard"                 = var.enable_kpi_dashboard ? "yes" : "no"
    "DeployTAODashboard"                 = var.enable_tao_dashboard ? "yes" : "no"
    "PrerequisitesQuickSight"            = var.enable_prerequisites_quicksight ? "yes" : "no"
    "PrerequisitesQuickSightPermissions" = var.enable_prerequisites_quicksight_permissions ? "yes" : "no"
    "QuickSightUser"                     = var.quicksights_username
  }
  providers = {
    aws = aws.cost_analysis
  }

  depends_on = [
    module.collector,
    module.source,
  ]
}

## We need to provision the read permissions stack in the management account  
resource "aws_cloudformation_stack" "cudos_read_permissions" {
  name          = var.stack_name_read_permissions
  capabilities  = ["CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  template_body = file("${path.module}/assets/cloudformation/cudos/deploy-data-read-permissions.yaml")

  parameters = {
    "AllowModuleReadInMgmt"            = "yes",
    "DataCollectionAccountID"          = local.cost_analysis_account_id,
    "OrganizationalUnitIds"            = local.organization_root_id,
    "IncludeBackupModule"              = "yes",
    "IncludeBudgetsModule"             = "yes",
    "IncludeComputeOptimizerModule"    = "yes",
    "IncludeCostAnomalyModule"         = "yes",
    "IncludeCostOptimizationHubModule" = "yes",
    "IncludeECSChargebackModule"       = "no",
    "IncludeInventoryCollectorModule"  = "yes",
    "IncludeRDSUtilizationModule"      = "yes",
    "IncludeRightsizingModule"         = "yes",
    "IncludeTAModule"                  = "yes",
    "IncludeTransitGatewayModule"      = "yes",
  }

  depends_on = [
    module.collector,
    module.dashboards,
    module.source,
  ]

  provider = aws.management
}

## We need to provision the data collection stack in the colletor account 
resource "aws_cloudformation_stack" "cudos_data_collection" {
  name          = var.stack_name_collectors
  capabilities  = ["CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  template_body = file("${path.module}/assets/cloudformation/cudos/deploy-data-collection.yaml")

  parameters = {
    "ManagementAccountID"              = local.management_account_id,
    "IncludeBackupModule"              = "yes",
    "IncludeBudgetsModule"             = "yes",
    "IncludeComputeOptimizerModule"    = "yes",
    "IncludeCostAnomalyModule"         = "yes",
    "IncludeCostOptimizationHubModule" = "yes",
    "IncludeECSChargebackModule"       = "no",
    "IncludeInventoryCollectorModule"  = "yes",
    "IncludeOrgDataModule"             = "yes",
    "IncludeRDSUtilizationModule"      = "yes",
    "IncludeRightsizingModule"         = "yes",
    "IncludeTAModule"                  = "yes",
    "IncludeTransitGatewayModule"      = "yes",
  }

  depends_on = [
    aws_cloudformation_stack.cudos_read_permissions,
    module.collector,
    module.dashboards,
    module.source,
  ]

  provider = aws.cost_analysis
}
