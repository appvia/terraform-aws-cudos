
## Craft and IAM policy that allows the account to access the bucket
data "aws_iam_policy_document" "stack_bucket_policy" {
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
      identifiers = [local.management_account_id]
    }
    resources = [
      format("arn:aws:s3:::%s", var.stacks_bucket_name),
      format("arn:aws:s3:::%s/*", var.stacks_bucket_name),
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
      identifiers = [local.management_account_id]
    }
    resources = [
      format("arn:aws:s3:::%s", var.stacks_bucket_name),
      format("arn:aws:s3:::%s/*", var.stacks_bucket_name),
    ]
  }
}

## Provision a bucket used to contain the cloudformation templates
# tfsec:ignore:aws-s3-enable-bucket-logging
module "cloudformation_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.2"

  attach_policy           = true
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = var.stacks_bucket_name
  expected_bucket_owner   = local.management_account_id
  force_destroy           = true
  ignore_public_acls      = true
  object_ownership        = "BucketOwnerPreferred"
  policy                  = data.aws_iam_policy_document.stack_bucket_policy.json
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

## Upload the cloudformation templates to the bucket
resource "aws_s3_object" "cloudformation_templates" {
  for_each = fileset("${path.module}/assets/cloudformation/", "**/*.yaml")

  bucket                 = module.cloudformation_bucket.s3_bucket_id
  etag                   = filemd5("${path.module}/assets/cloudformation/${each.value}")
  key                    = each.value
  server_side_encryption = "AES256"
  source                 = "${path.module}/assets/cloudformation/${each.value}"
}

## Setup the replication from the management account to the collector account
## to receive the CUR data
# tfsec:ignore:aws-s3-enable-bucket-logging
# tfsec:ignore:aws-iam-no-policy-wildcards
module "source" {
  count  = var.enable_curv1 ? 1 : 0
  source = "github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-source?ref=4.0.2"

  # The destination bucket to repliaction the CUR data to
  destination_bucket_arn = var.destination_bucket_arn
  # Adding the resource tags to all resources created by this module
  tags = var.tags

  providers = {
    aws.useast1 = aws.us_east_1
  }
}

## Provision the stack contain the cora data exports in the management account
## Deployment of same stack the management account
resource "aws_cloudformation_stack" "data_export_management" {
  capabilities = ["CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  name         = var.stack_name_data_exports_source
  on_failure   = "ROLLBACK"
  tags         = var.tags
  template_url = format("%s/cudos/%s", local.stacks_base_url, "data-exports-aggregation.yaml")

  parameters = {
    "DestinationAccountId" = var.destination_account_id,
    "EnableSCAD"           = var.enable_scad ? "yes" : "no",
    "ManageCOH"            = var.enable_compute_optimizization_hub ? "yes" : "no",
    "ManageCUR2"           = "yes",
  }

  lifecycle {
    ignore_changes = [
      capabilities,
    ]
  }

  depends_on = [
    aws_s3_object.cloudformation_templates,
    module.source,
  ]
}

## We need to provision the read permissions stack within the management account, note
## this effectively creates a stackset which is deployed to all accounts within the
## organization
resource "aws_cloudformation_stack" "cudos_read_permissions" {
  count = local.enable_read_permissions ? 1 : 0

  name         = var.stack_name_read_permissions
  capabilities = ["CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  tags         = var.tags
  template_url = format("%s/cudos/%s", local.stacks_base_url, "deploy-data-read-permissions.yaml")

  parameters = {
    "AllowModuleReadInMgmt"           = "yes",
    "DataCollectionAccountID"         = var.destination_account_id,
    "IncludeBackupModule"             = var.enable_backup_module ? "yes" : "no",
    "IncludeBudgetsModule"            = var.enable_budgets_module ? "yes" : "no",
    "IncludeComputeOptimizerModule"   = var.enable_compute_optimizer_module ? "yes" : "no",
    "IncludeCostAnomalyModule"        = var.enable_cost_anomaly_module ? "yes" : "no",
    "IncludeECSChargebackModule"      = var.enable_ecs_chargeback_module ? "yes" : "no",
    "IncludeHealthEventsModule"       = var.enable_health_events_module ? "yes" : "no"
    "IncludeInventoryCollectorModule" = var.enable_inventory_module ? "yes" : "no",
    "IncludeRDSUtilizationModule"     = var.enable_rds_utilization_module ? "yes" : "no",
    "IncludeRightsizingModule"        = var.enable_rightsizing_module ? "yes" : "no",
    "IncludeTAModule"                 = var.enable_tao_module ? "yes" : "no",
    "IncludeTransitGatewayModule"     = var.enable_transit_gateway_module ? "yes" : "no",
    "OrganizationalUnitIds"           = local.organizational_unit_ids != null ? local.organizational_unit_ids : ""
  }

  depends_on = [
    aws_s3_object.cloudformation_templates,
    module.source,
  ]
}
