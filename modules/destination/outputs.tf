
output "cloudformation_bucket_arn" {
  description = "The name of the bucket where to store the CloudFormation"
  value       = module.cloudformation.s3_bucket_arn
}

output "destination_bucket_arn" {
  description = "The name of the bucket where to replicate the data from the CUR"
  value       = module.collector.cur_bucket_arn
}

output "destination_bucket_name" {
  description = "The name of the bucket where to replicate the data from the CUR"
  value       = module.collector.cur_bucket_name
}

output "dashboard_bucket_arn" {
  description = "The name of the bucket where to store the dashboards"
  value       = module.dashboard_bucket.s3_bucket_arn
}
