variable "destination_account_id" {
  description = "The AWS account ID for the destination account"
  type        = string
}

variable "destination_bucket_arn" {
  description = "S3 URI of the CID data collection bucket in the destination account (e.g. s3://cid-123456789012-local-assets). Passed to the data exports stack as SecondaryDestinationBucket."
  type        = string

  validation {
    condition     = can(regex("^s3://[a-z0-9][a-z0-9.-]{1,61}[a-z0-9](/.*)?$", var.destination_bucket_arn))
    error_message = "destination_bucket_arn must be a valid S3 URI (e.g. s3://cid-123456789012-local-assets)."
  }
}

variable "enable_focus" {
  description = "Indicates if the FOCUS module should be enabled"
  type        = bool
  default     = false
}

variable "enable_cur2" {
  description = "Indicates if the CUR2 module should be enabled"
  type        = bool
  default     = true
}

variable "resource_prefix" {
  description = "The prefix for the resources"
  type        = string
  default     = "cid"
}

variable "enable_backup_module" {
  description = "Indicates if the Backup module should be enabled"
  type        = bool
  default     = true
}

variable "enable_budgets_module" {
  description = "Indicates if the Budget module should be enabled"
  type        = bool
  default     = true
}

variable "enable_compute_optimizer_module" {
  description = "Indicates if the Compute Optimizer module should be enabled"
  type        = bool
  default     = true
}

variable "enable_compute_optimization_hub" {
  description = "Indicates if the Compute Optimization Hub module should be enabled"
  type        = bool
  default     = false
}

variable "enable_license_manager_module" {
  description = "Indicates if the License Manager module should be enabled"
  type        = bool
  default     = false
}

variable "cur2_time_granularity" {
  description = "CUR 2.0 export time granularity. Changing this requires stack redeployment and data backfill."
  type        = string
  default     = "HOURLY"

  validation {
    condition     = contains(["HOURLY", "DAILY", "MONTHLY"], var.cur2_time_granularity)
    error_message = "cur2_time_granularity must be HOURLY, DAILY, or MONTHLY."
  }
}

variable "enable_cost_anomaly_module" {
  description = "Indicates if the Cost Anomaly module should be enabled"
  type        = bool
  default     = true
}

variable "enable_ecs_chargeback_module" {
  description = "Indicates if the ECS Chargeback module should be enabled"
  type        = bool
  default     = false
}

variable "enable_health_events_module" {
  description = "Indicates if the Health Events module should be enabled"
  type        = bool
  default     = true
}

variable "enable_inventory_module" {
  description = "Indicates if the Inventory module should be enabled"
  type        = bool
  default     = true
}

variable "enable_rds_utilization_module" {
  description = "Indicates if the RDS Utilization module should be enabled"
  type        = bool
  default     = true
}

variable "enable_rightsizing_module" {
  description = "Indicates if the Rightsizing module should be enabled"
  type        = bool
  default     = true
}

variable "enable_scad" {
  description = "Indicates if the SCAD module should be enabled, only available when Cora enabled"
  type        = bool
  default     = false
}

variable "enable_tao_module" {
  description = "Indicates if the TAO module should be enabled"
  type        = bool
  default     = true
}

variable "enable_transit_gateway_module" {
  description = "Indicates if the Transit Gateway module should be enabled"
  type        = bool
  default     = true
}

variable "organizational_unit_ids" {
  description = "List of organization units where the read permissions stack will be deployed"
  type        = list(string)
  default     = []
}

variable "stack_name_data_exports_source" {
  description = "The name of the CloudFormation stack to create the Data Exports"
  type        = string
  default     = "CidDataExportsSourceStack"
}

variable "stack_name_read_permissions" {
  description = "The name of the CloudFormation stack to create the collectors"
  type        = string
  default     = "CidDataCollectionReadPermissionsStack"
}

variable "stacks_bucket_name" {
  description = "The name of the bucket to store the CloudFormation templates"
  type        = string
  default     = "cid-cloudformation-templates"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
