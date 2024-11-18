#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################

locals {
  ## Name of the bucket where the cloudformation scripts are stored 
  cloudformation_bucket_name = "cid-cloudformation-templates"
  ## The external URL for the cloudformation bucket 
  cloudformation_bucket_url = format("https://%s.s3.%s.amazonaws.com", local.cloudformation_bucket_name, "eu-west-2")
}

module "destination" {
  source = "../../modules/destination"

  cloudformation_bucket_url = local.cloudformation_bucket_url
  dashboards_bucket_name    = var.dashboard_bucket_name
  enable_sso                = true
  management_account_id     = module.source.management_account_id
  quicksights_username      = var.quicksights_username
  saml_metadata             = file("${path.module}/assets/saml-metadata.xml")
  tags                      = var.tags

  providers = {
    aws           = aws.cost_analysis
    aws.us_east_1 = aws.cost_analysis_us_east_1
  }
}

module "source" {
  source = "../../modules/source"

  ## The account id for the destination below
  destination_account_id        = "1234343434"
  destination_bucket_name       = module.destination.destination_bucket_arn
  enable_backup_module          = true
  enable_budgets_module         = true
  enable_cora_data_exports      = true
  enable_ecs_chargeback_module  = true
  enable_health_events_module   = true
  enable_inventory_module       = true
  enable_rds_utilization_module = true
  enable_scad                   = true
  stacks_bucket_name            = local.cloudformation_bucket_name
  tags                          = var.tags

  providers = {
    aws           = aws.management
    aws.us_east_1 = aws.management_us_east_1
  }
}

