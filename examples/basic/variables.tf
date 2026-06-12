variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Environment = "Production"
  }
}

variable "identity_center_instance_arn" {
  description = "ARN of the IAM Identity Center instance. When null, the first instance returned by aws_ssoadmin_instances is used."
  type        = string
  default     = null
}

variable "quicksight_account_name" {
  description = "Display name for the QuickSight account subscription"
  type        = string
  default     = "cid-quicksight"
}

variable "quicksight_edition" {
  description = "QuickSight edition. IAM Identity Center requires ENTERPRISE or ENTERPRISE_AND_Q."
  type        = string
  default     = "ENTERPRISE"
}

variable "quicksight_notification_email" {
  description = "Email address for QuickSight subscription notifications"
  type        = string
  default     = "quicksight-admin@example.com"
}

variable "quicksight_admin_group" {
  description = "IAM Identity Center group name with QuickSight admin permissions. Required when authentication_method is IAM_IDENTITY_CENTER."
  type        = string
  default     = "CID-QuickSight-Admins"
}

variable "quicksight_author_groups" {
  description = "IAM Identity Center group names to grant QuickSight author permissions"
  type        = list(string)
  default     = ["CID-QuickSight-Authors"]
}

variable "quicksight_reader_groups" {
  description = "IAM Identity Center group names to grant QuickSight reader permissions"
  type        = list(string)
  default     = ["CID-QuickSight-Readers"]
}
