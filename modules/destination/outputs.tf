
output "cloudformation_bucket_arn" {
  description = "The name of the bucket where to store the CloudFormation"
  value       = module.cloudformation.s3_bucket_arn
}

output "destination_bucket_name" {
  description = "The name of the bucket where to replicate the data from the CUR"
  value       = format("cid-%s-local-assets", local.account_id)
}

output "destination_bucket_arn" {
  description = "The name of the bucket where to replicate the data from the CUR"
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
