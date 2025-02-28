
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Environment = "Production"
  }
}

variable "quicksight_dashboard_owner" {
  description = "The username to use for QuickSight"
  type        = string
  default     = "admin"
}
