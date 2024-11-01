
output "management_account_id" {
  description = "The AWS account ID for the management account"
  value       = local.management_account_id
}

output "cloudformation_bucket_name" {
  description = "The name of the bucket to store the CloudFormation templates"
  value       = var.stacks_bucket_name
}

output "cloudformation_bucket_url" {
  description = "The URL of the bucket to store the CloudFormation templates"
  value       = format("https://%s.s3.%s.amazonaws.com", var.stacks_bucket_name, local.region)
}


