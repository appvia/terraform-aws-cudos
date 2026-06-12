
output "cloudformation_bucket_arn" {
  description = "The name of the bucket where to store the CloudFormation"
  value       = module.cloudformation.s3_bucket_arn
}

output "cloudformation_templates_prefix" {
  description = "The S3 key prefix (includes hash) for CloudFormation templates"
  value       = local.stacks_templates_prefix
}

output "destination_bucket_name" {
  description = "Name of the CID data collection bucket created by the data exports stack in the destination account"
  value       = format("cid-%s-local-assets", local.account_id)
}

output "destination_bucket_arn" {
  description = "S3 URI of the CID data collection bucket in the destination account. Pass to the source module as destination_bucket_arn."
  value       = format("s3://cid-%s-local-assets", local.account_id)
}

output "dashboard_bucket_arn" {
  description = "The name of the bucket where to store the dashboards"
  value       = module.dashboard_bucket.s3_bucket_arn
}

output "cfn_dashboards_version" {
  description = "The version of the CUDOS dashboards"
  value       = var.cfn_dashboards_version
}
