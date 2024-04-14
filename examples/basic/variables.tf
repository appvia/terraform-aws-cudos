
variable "dashboard_bucket_name" {
  description = "The name of the bucket to store the dashboards"
  type        = string
  default     = "dashboard-bucket-dev"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Environment = "Production"
  }
}

variable "quicksights_username" {
  description = "The username to use for QuickSight"
  type        = string
  default     = "admin"
}
