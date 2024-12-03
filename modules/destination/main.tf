
## Craft and IAM policy that allows the account to access the bucket
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
    ]
    principals {
      type        = "AWS"
      identifiers = [local.account_id]
    }
    resources = [
      format("arn:aws:s3:::%s", var.cloudformation_bucket_name),
      format("arn:aws:s3:::%s/*", var.cloudformation_bucket_name),
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    principals {
      type        = "AWS"
      identifiers = [local.account_id]
    }
    resources = [
      format("arn:aws:s3:::%s", var.cloudformation_bucket_name),
      format("arn:aws:s3:::%s/*", var.cloudformation_bucket_name),
    ]
  }
}

## Provision a bucket used to contain the cloudformation templates
# tfsec:ignore:aws-s3-enable-bucket-logging
module "cloudformation" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.2.2"

  attach_policy           = true
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = var.cloudformation_bucket_name
  expected_bucket_owner   = local.account_id
  force_destroy           = true
  ignore_public_acls      = true
  object_ownership        = "BucketOwnerPreferred"
  policy                  = data.aws_iam_policy_document.bucket_policy.json
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
}

## Create a lifecycle rule to old versions of the objects in the bucket
resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  bucket = module.cloudformation.s3_bucket_id

  rule {
    id     = "DeleteOldVersions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}

## Upload the cloudformation templates to the bucket
resource "aws_s3_object" "cloudformation_templates" {
  for_each = fileset("${path.module}/assets/cloudformation/", "**/*.yaml")

  bucket                 = module.cloudformation.s3_bucket_id
  etag                   = filemd5("${path.module}/assets/cloudformation/${each.value}")
  key                    = each.value
  server_side_encryption = "AES256"
  source                 = "${path.module}/assets/cloudformation/${each.value}"
}

## Provision enterprise quicksight if enabled
resource "aws_quicksight_account_subscription" "subscription" {
  count = var.enable_quicksight_subscription ? 1 : 0

  account_name          = var.quicksight_subscription_account_name
  authentication_method = var.quicksight_subscription_authentication_method
  edition               = var.quicksight_subscription_edition
  notification_email    = var.quicksight_subscription_email
}

## Provision a administator user in quicksight
resource "aws_quicksight_user" "admin" {
  count = local.enable_admin ? 1 : 0

  email         = var.quicksight_admin_email
  identity_type = "QUICKSIGHT"
  namespace     = "default"
  user_name     = var.quicksight_admin_username
  user_role     = "ADMIN"
}

## Provision a SAML identity provider in the data collection account - this will be
## used to authenticate sso users into quicksights
resource "aws_iam_saml_provider" "saml" {
  count = var.enable_sso ? 1 : 0

  name                   = "aws-cudos-sso"
  saml_metadata_document = var.saml_metadata
  tags                   = var.tags
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
    resources = ["arn:aws:quicksight::${local.account_id}:user/$${aws:userid}"]
  }
}

## Provision and IAM role to be assumed by the SAML identity provider; this role will
## be used to authenticate users into quicksights
resource "aws_iam_role" "cudos_sso" {
  count = var.enable_sso ? 1 : 0

  name               = "aws-cudos-sso"
  assume_role_policy = data.aws_iam_policy_document.cudos_sso[0].json
  tags               = var.tags
}

## Attach an inline policy to the IAM role
resource "aws_iam_role_policy" "cudos_sso" {
  count = var.enable_sso ? 1 : 0

  name   = "quicksight-permissions"
  policy = data.aws_iam_policy_document.cudos_sso_permissions[0].json
  role   = aws_iam_role.cudos_sso[0].name
}

## Craft and IAM policy that allows the account to access the bucket
data "aws_iam_policy_document" "dashboards_bucket_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
    ]
    principals {
      type        = "AWS"
      identifiers = [local.account_id]
    }
    resources = [
      format("arn:aws:s3:::%s", var.dashboards_bucket_name),
      format("arn:aws:s3:::%s/*", var.dashboards_bucket_name),
    ]
  }
}

## Provision a bucket used to contain the cudos dashboards - note this
## bucket must be public due to the consuming tterraform module
#
# tfsec:ignore:aws-s3-enable-bucket-logging
module "dashboard_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.2.2"

  attach_policy           = true
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = var.dashboards_bucket_name
  expected_bucket_owner   = local.account_id
  force_destroy           = true
  ignore_public_acls      = true
  object_ownership        = "BucketOwnerPreferred"
  policy                  = data.aws_iam_policy_document.dashboards_bucket_policy.json
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
}

## First we configure the collector to accept the CUR (Cost and Usage Report) from the source account
# tfsec:ignore:aws-s3-enable-bucket-logging
module "collector" {
  source = "github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-destination?ref=4.0.2"

  # Source account whom will be replicating the CUR data to the collector account
  source_account_ids = local.payer_account_ids
  # Indicates if we should create CUR data in the cost analysis account
  create_cur = false
  # Adding the tags to the resources
  tags = var.tags

  providers = {
    aws.useast1 = aws.us_east_1
  }

  depends_on = [
    aws_quicksight_user.admin
  ]
}

## Provision the cloud intelligence dashboards
module "dashboards" {
  source = "github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cid-dashboards?ref=4.0.2"

  stack_name      = var.stack_name_cloud_intelligence
  stack_tags      = var.tags
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

  depends_on = [
    aws_cloudformation_stack.core_data_export_destination,
    aws_quicksight_account_subscription.subscription,
    aws_quicksight_user.admin,
    module.collector,
  ]
}

## We need to provision the data collection stack in the colletor account
resource "aws_cloudformation_stack" "cudos_data_collection" {
  name         = var.stack_name_collectors
  capabilities = ["CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  tags         = var.tags
  template_url = format("%s/cudos/%s", local.bucket_url, "deploy-data-collection.yaml")

  parameters = {
    "IncludeBackupModule"             = var.enable_backup_module ? "yes" : "no",
    "IncludeBudgetsModule"            = var.enable_budgets_module ? "yes" : "no",
    "IncludeComputeOptimizerModule"   = var.enable_compute_optimizer_module ? "yes" : "no",
    "IncludeCostAnomalyModule"        = var.enable_cost_anomaly_module ? "yes" : "no",
    "IncludeECSChargebackModule"      = var.enable_ecs_chargeback_module ? "yes" : "no",
    "IncludeHealthEventsModule"       = var.enable_health_events_module ? "yes" : "no"
    "IncludeInventoryCollectorModule" = var.enable_inventory_module ? "yes" : "no",
    "IncludeLicenseManagerModule"     = var.enable_license_manager_module ? "yes" : "no",
    "IncludeOrgDataModule"            = var.enable_org_data_module ? "yes" : "no",
    "IncludeRDSUtilizationModule"     = var.enable_rds_utilization_module ? "yes" : "no",
    "IncludeRightsizingModule"        = var.enable_rightsizing_module ? "yes" : "no",
    "IncludeTAModule"                 = var.enable_tao_module ? "yes" : "no",
    "IncludeTransitGatewayModule"     = var.enable_transit_gateway_module ? "yes" : "no",
    "ManagementAccountID"             = join(",", local.payer_account_ids),
  }

  depends_on = [
    aws_s3_object.cloudformation_templates,
    module.collector,
    module.dashboards,
  ]
}

## Provision the stack contain the cora data exports in the management account
## Deployment of same stack the management account
resource "aws_cloudformation_stack" "core_data_export_destination" {
  capabilities = ["CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  name         = var.stack_name_cora_data_exports
  on_failure   = "ROLLBACK"
  tags         = var.tags
  template_url = format("%s/cudos/%s", local.bucket_url, "data-exports-aggregation.yaml")

  parameters = {
    "DestinationAccountId" = local.account_id,
    "EnableSCAD"           = var.enable_scad ? "yes" : "no",
    "ManageCOH"            = "no",
    "ManageCUR2"           = "yes",
    "SourceAccountIds"     = join(",", local.payer_account_ids),
  }

  lifecycle {
    ignore_changes = [
      capabilities,
    ]
  }

  depends_on = [
    aws_s3_object.cloudformation_templates,
    module.collector,
  ]
}

