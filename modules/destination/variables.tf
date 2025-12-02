
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "cloudformation_bucket_name" {
  description = "The name of the bucket to store the CloudFormation"
  type        = string
}

variable "payer_accounts" {
  description = "List of additional payer accounts to be included in the collectors module"
  type        = list(string)
  default     = []
}

variable "enable_quicksight_subscription" {
  description = "Enable QuickSight subscription"
  type        = bool
  default     = false
}

variable "saml_provider_name" {
  description = "The name of the SAML provider"
  type        = string
  default     = "aws-cudos-sso"
}

variable "saml_iam_role_name" {
  description = "Name of the role all authentication users are initially given"
  type        = string
  default     = "aws-cudos-sso"
}

variable "quicksight_subscription_email" {
  description = "The email address for the QuickSight quicksight_subscription edition"
  type        = string
  default     = null
}

variable "quicksight_subscription_authentication_method" {
  description = "The identity for the QuickSight quicksight_subscription edition"
  type        = string
  default     = "IAM_AND_QUICKSIGHT"
}

variable "quicksight_subscription_edition" {
  description = "The edition for the QuickSight quicksight_subscription"
  type        = string
  default     = "ENTERPRISE"
}

variable "quicksight_subscription_account_name" {
  description = "The account name for the QuickSight quicksight_subscription edition"
  type        = string
  default     = null
}

variable "stack_name_cloud_intelligence" {
  description = "The name of the CloudFormation stack to create the dashboards"
  type        = string
  default     = "CI-Cloud-Intelligence-Dashboards"
}

variable "stack_name_collectors" {
  description = "The name of the CloudFormation stack to create the collectors"
  type        = string
  default     = "CidDataCollectionStack"
}

variable "stack_name_cora_data_exports" {
  description = "The name of the CloudFormation stack to create the Data Exports"
  type        = string
  default     = "CidDataExportsDestinationStack"
}

variable "dashboards_bucket_name" {
  description = "The name of the bucket to store the dashboards configurations"
  type        = string
}

variable "enable_quicksight_admin" {
  description = "Enable the creation of an admin user (var.quicksight_admin_username) in QuickSight"
  type        = bool
  default     = true
}

variable "quicksight_admin_username" {
  description = "The username for the QuickSight admin user"
  type        = string
  default     = "admin"
}

variable "quicksight_admin_email" {
  description = "The email address for the QuickSight admin user. Required if var.create_quicksight_admin_user is true"
  type        = string
  default     = null
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

variable "enable_license_manager_module" {
  description = "Indicates if the License Manager module should be enabled"
  type        = bool
  default     = false
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

variable "enable_compute_optimization_hub" {
  description = "Indicates if the Compute Optimization Hub components into destination account"
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
  default     = ""
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

variable "quicksight_dashboard_owner" {
  description = "The username for the QuickSight user who will own the dashboards. This user needs to exist. By default, it will be the admin user which is created by the module."
  type        = string
  default     = "admin"
}

variable "quicksight_users" {
  description = "Map of user accounts to be registered in QuickSight"
  type = map(object({
    identity_type = string
    namespace     = optional(string, "default")
    role          = optional(string, "READER")
  }))
  default = {}
}

variable "enable_compute_optimizization_hub" {
  description = "Indicates if the Compute Optimizization Hub module should be enabled"
  type        = bool
  default     = false
}

variable "stack_name_data_exports" {
  description = "The name of the CloudFormation stack to create the Data Exports"
  type        = string
  default     = "CidDataExportsDestinationStack"
}

variable "enable_lake_formation" {
  description = "Indicates if the Lake Formation should be enabled"
  type        = bool
  default     = false
}

variable "data_collection_primary_tag_name" {
  description = "The primary tag name for the data collection"
  type        = string
  default     = "owner"
}

variable "data_collection_secondary_tag_name" {
  description = "The secondary tag name for the data collection"
  type        = string
  default     = "environment"
}

variable "athena_workgroup" {
  description = "The name of the Athena workgroup"
  type        = string
  default     = ""
}

variable "athena_query_results_bucket" {
  description = "The name of the Athena query results bucket"
  type        = string
  default     = ""
}

variable "database_name" {
  description = "The name of the Athena database"
  type        = string
  default     = ""
}

variable "glue_data_catalog" {
  description = "The name of the Glue data catalog"
  type        = string
  default     = "AwsDataCatalog"
}

variable "dashboard_suffix" {
  description = "The suffix for the dashboards"
  type        = string
  default     = ""
}

variable "quicksight_data_source_role_name" {
  description = "The name of the Quicksight data source role"
  type        = string
  default     = "CidQuickSightDataSourceRole"
}

variable "quicksight_data_set_refresh_schedule" {
  description = "The schedule for the Quicksight data set refresh"
  type        = string
  default     = ""
}

variable "lambda_layer_bucket_prefix" {
  description = "The prefix for the Lambda layer bucket"
  type        = string
  default     = "aws-managed-cost-intelligence-dashboards"
}

variable "data_buckets_kms_keys_arns" {
  description = "The ARNs of the KMS keys for the data buckets"
  type        = list(string)
  default     = []
}

variable "deployment_type" {
  description = "The type of deployment"
  type        = string
  default     = "Terraform"
}

variable "share_dashboard" {
  description = "Indicates if the dashboard should be shared"
  type        = string
  default     = "yes"
}

variable "cfn_dashboards_version" {
  description = "The version of the CUDOS dashboards"
  type        = string
  default     = "4.3.7"
}
