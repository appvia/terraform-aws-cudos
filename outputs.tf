
output "destination_bucket_name" {
  description = "The name of the destination bucket"
  value       = module.cloudformation_bucket.s3_bucket_id
}

output "destination_bucket_arn" {
  description = "The ARN of the destination bucket"
  value       = format("arn:aws:s3:::%s", module.cloudformation_bucket.s3_bucket_id)
}

output "destination_bucket_short_url" {
  description = "The domain name of the destination bucket"
  value       = format("s3://%s", module.cloudformation_bucket.s3_bucket_id)
}

output "destination_bucket_website_url" {
  description = "The URL for the destination bucket"
  value       = format("https://%s.amazonaws.com", module.cloudformation_bucket.s3_bucket_id)
}
