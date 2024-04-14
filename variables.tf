
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
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

variable "dashbords_bucket_name" {
  description = "The name of the bucket to store the dashboards configurations"
  type        = string
}

variable "enable_sso" {
  description = "Enable integration with identity center for QuickSight"
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

variable "quicksights_username" {
  description = "The username for the QuickSight user"
  type        = string
  default     = "admin"
}
