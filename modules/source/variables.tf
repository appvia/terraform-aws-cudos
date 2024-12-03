
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "destination_account_id" {
  description = "The AWS account ID for the destination account"
  type        = string
}

variable "destination_bucket_arn" {
  description = "The ARN of the bucket where to replicate the data from the CUR"
  type        = string
}

variable "stacks_bucket_name" {
  description = "The name of the bucket to store the CloudFormation templates"
  type        = string
  default     = "cid-cloudformation-templates"
}

variable "stack_name_read_permissions" {
  description = "The name of the CloudFormation stack to create the collectors"
  type        = string
  default     = "CidDataCollectionReadPermissionsStack"
}

variable "stack_name_cora_data_exports_source" {
  description = "The name of the CloudFormation stack to create the CORA Data Exports"
  type        = string
  default     = "CidCoraCoraDataExportsSourceStack"
}

variable "enable_cost_anomaly_module" {
  description = "Indicates if the Cost Anomaly module should be enabled"
  type        = bool
  default     = true
}

variable "enable_scad" {
  description = "Indicates if the SCAD module should be enabled, only available when Cora enabled"
  type        = bool
  default     = false
}

variable "enable_health_events_module" {
  description = "Indicates if the Health Events module should be enabled"
  type        = bool
  default     = true
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

variable "enable_ecs_chargeback_module" {
  description = "Indicates if the ECS Chargeback module should be enabled"
  type        = bool
  default     = false
}

variable "enable_compute_optimizer_module" {
  description = "Indicates if the Compute Optimizer module should be enabled"
  type        = bool
  default     = true
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

variable "organizational_unit_ids" {
  description = "List of organization units where the read permissions stack will be deployed"
  type        = list(string)
  default     = []
}
