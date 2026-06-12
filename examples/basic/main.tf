#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################

locals {
  ## Name of the bucket where the cloudformation scripts are stored
  cloudformation_bucket_name = "cid-cloudformation-templates"
  ## Name of the bucket where the dashboards are stored
  dashboard_bucket_name = "cid-dashboards"
}

module "destination" {
  source = "../../modules/destination"

  cloudformation_bucket_name = local.cloudformation_bucket_name
  dashboards_bucket_name     = local.dashboard_bucket_name
  enable_quicksight_admin    = false
  enable_sso                 = false
  payer_accounts             = ["1234343434"]
  ## Must be a user in var.quicksight_admin_group with QuickSight access in Identity Center
  quicksight_dashboard_owner = "finops-admin"
  tags                       = var.tags

  providers = {
    aws = aws.cost_analysis
  }

  depends_on = [
    aws_quicksight_account_subscription.subscription,
  ]
}

module "source" {
  source = "../../modules/source"

  ## The account id for the destination below
  destination_account_id        = "1234343434"
  enable_backup_module          = true
  enable_budgets_module         = true
  enable_ecs_chargeback_module  = true
  enable_health_events_module   = true
  enable_inventory_module       = true
  enable_rds_utilization_module = true
  enable_scad                   = true
  stacks_bucket_name            = local.cloudformation_bucket_name
  tags                          = var.tags

  providers = {
    aws = aws.management
  }
}

