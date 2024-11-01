
output "destination_bucket_arn" {
  description = "The name of the bucket where to replicate the data from the CUR"
  value       = module.collector.cur_bucket_arn
}

output "destination_bucket_name" {
  description = "The name of the bucket where to replicate the data from the CUR"
  value       = module.collector.cur_bucket_name
}

