
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "enable_quicksight_enterprise" {
  description = "Enable QuickSight Enterprise edition"
  type        = bool
  default     = false
}

variable "enterprise_email" {
  description = "The email address for the QuickSight Enterprise edition"
  type        = string
  default     = null
}

variable "enterprise_account_name" {
  description = "The account name for the QuickSight Enterprise edition"
  type        = string
  default     = null
}

variable "stacks_bucket_name" {
  description = "The name of the bucket to store the CloudFormation templates"
  type        = string
  default     = "cid-cloudformation-templates"
}

variable "stack_name_cloud_intelligence" {
  description = "The name of the CloudFormation stack to create the dashboards"
  type        = string
  default     = "CI-Cloud-Intelligence-Dashboards"
}

variable "stack_name_read_permissions" {
  description = "The name of the CloudFormation stack to create the collectors"
  type        = string
  default     = "CidDataCollectionReadPermissionsStack"
}

variable "stack_name_collectors" {
  description = "The name of the CloudFormation stack to create the collectors"
  type        = string
  default     = "CidDataCollectionStack"
}

variable "dashboards_bucket_name" {
  description = "The name of the bucket to store the dashboards configurations"
  type        = string
}

variable "enable_sso" {
  description = "Enable integration with identity center for QuickSight"
  type        = bool
  default     = true
}

variable "enable_cost_anomaly_module" {
  description = "Indicates if the Cost Anomaly module should be enabled"
  type        = bool
  default     = true
}

variable "enable_health_events" {
  description = "Indicates if the Health Events module should be enabled"
  type        = bool
  default     = true
}

variable "enable_aws_newsfeed" {
  description = "Indicates if the AWS News Feed module should be enabled"
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

variable "enable_org_data_module" {
  description = "Indicates if the Organization Data module should be enabled"
  type        = bool
  default     = true
}

variable "enable_transit_gateway_module" {
  description = "Indicates if the Transit Gateway module should be enabled"
  type        = bool
  default     = true
}

variable "enable_tao_module" {
  description = "Indicates if the TAO module should be enabled"
  type        = bool
  default     = true
}

variable "enable_cost_optimization_hub_module" {
  description = "Indicates if the Compute Optimization Hub module should be enabled"
  type        = bool
  default     = true
}

variable "enable_compute_optimizer_module" {
  description = "Indicates if the Compute Optimizer module should be enabled"
  type        = bool
  default     = true
}

variable "enable_cudos_v5_dashboard" {
  description = "Indicates if the CUDOS V5 framework should be enabled"
  type        = bool
  default     = true
}

variable "enable_cudos_dashboard" {
  description = "Indicates if the CUDOS dashboard should be enabled"
  type        = bool
  default     = false
}

variable "enable_compute_optimizer_dashboard" {
  description = "Indicates if the Compute Optimizer dashboard should be enabled"
  type        = bool
  default     = true
}

variable "enable_cost_intelligence_dashboard" {
  description = "Indicates if the Cost Intelligence dashboard should be enabled"
  type        = bool
  default     = true
}

variable "enable_kpi_dashboard" {
  description = "Indicates if the KPI dashboard should be enabled"
  type        = bool
  default     = true
}

variable "enable_tao_dashboard" {
  description = "Indicates if the TAO dashboard should be enabled"
  type        = bool
  default     = false
}

variable "enable_prerequisites_quicksight" {
  description = "Indicates if the prerequisites for QuickSight should be enabled"
  type        = bool
  default     = true
}

variable "enable_prerequisites_quicksight_permissions" {
  description = "Indicates if the prerequisites for QuickSight permissions should be enabled"
  type        = bool
  default     = true
}

variable "saml_metadata" {
  description = "The configuration for the SAML identity provider"
  type        = string
  default     = null
}

variable "quicksight_groups" {
  description = "Map of groups with user membership to be added to QuickSight"
  type = map(object({
    description = optional(string)
    namespace   = optional(string)
    members     = optional(list(string), [])
  }))
  default = {}
}

variable "quicksights_username" {
  description = "The username for the QuickSight user"
  type        = string
  default     = "admin"
}

variable "quicksight_users" {
  description = "Map of user accounts to be registered in QuickSight"
  type = map(object({
    role = optional(string, "READER")
  }))
  default = {}
}

