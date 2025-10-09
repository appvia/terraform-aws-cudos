<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudformation_bucket_name"></a> [cloudformation\_bucket\_name](#input\_cloudformation\_bucket\_name) | The name of the bucket to store the CloudFormation | `string` | n/a | yes |
| <a name="input_dashboards_bucket_name"></a> [dashboards\_bucket\_name](#input\_dashboards\_bucket\_name) | The name of the bucket to store the dashboards configurations | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | n/a | yes |
| <a name="input_athena_query_results_bucket"></a> [athena\_query\_results\_bucket](#input\_athena\_query\_results\_bucket) | The name of the Athena query results bucket | `string` | `""` | no |
| <a name="input_athena_workgroup"></a> [athena\_workgroup](#input\_athena\_workgroup) | The name of the Athena workgroup | `string` | `""` | no |
| <a name="input_cfn_dashboards_version"></a> [cfn\_dashboards\_version](#input\_cfn\_dashboards\_version) | The version of the CUDOS dashboards | `string` | `"4.3.7"` | no |
| <a name="input_dashboard_suffix"></a> [dashboard\_suffix](#input\_dashboard\_suffix) | The suffix for the dashboards | `string` | `""` | no |
| <a name="input_data_buckets_kms_keys_arns"></a> [data\_buckets\_kms\_keys\_arns](#input\_data\_buckets\_kms\_keys\_arns) | The ARNs of the KMS keys for the data buckets | `list(string)` | `[]` | no |
| <a name="input_data_collection_primary_tag_name"></a> [data\_collection\_primary\_tag\_name](#input\_data\_collection\_primary\_tag\_name) | The primary tag name for the data collection | `string` | `"Owner"` | no |
| <a name="input_data_collection_secondary_tag_name"></a> [data\_collection\_secondary\_tag\_name](#input\_data\_collection\_secondary\_tag\_name) | The secondary tag name for the data collection | `string` | `"Environment"` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the Athena database | `string` | `""` | no |
| <a name="input_deployment_type"></a> [deployment\_type](#input\_deployment\_type) | The type of deployment | `string` | `"Terraform"` | no |
| <a name="input_enable_backup_module"></a> [enable\_backup\_module](#input\_enable\_backup\_module) | Indicates if the Backup module should be enabled | `bool` | `true` | no |
| <a name="input_enable_budgets_module"></a> [enable\_budgets\_module](#input\_enable\_budgets\_module) | Indicates if the Budget module should be enabled | `bool` | `true` | no |
| <a name="input_enable_compute_optimizer_dashboard"></a> [enable\_compute\_optimizer\_dashboard](#input\_enable\_compute\_optimizer\_dashboard) | Indicates if the Compute Optimizer dashboard should be enabled | `bool` | `true` | no |
| <a name="input_enable_compute_optimizer_module"></a> [enable\_compute\_optimizer\_module](#input\_enable\_compute\_optimizer\_module) | Indicates if the Compute Optimizer module should be enabled | `bool` | `true` | no |
| <a name="input_enable_compute_optimizization_hub"></a> [enable\_compute\_optimizization\_hub](#input\_enable\_compute\_optimizization\_hub) | Indicates if the Compute Optimizization Hub module should be enabled | `bool` | `false` | no |
| <a name="input_enable_cost_anomaly_module"></a> [enable\_cost\_anomaly\_module](#input\_enable\_cost\_anomaly\_module) | Indicates if the Cost Anomaly module should be enabled | `bool` | `true` | no |
| <a name="input_enable_cost_intelligence_dashboard"></a> [enable\_cost\_intelligence\_dashboard](#input\_enable\_cost\_intelligence\_dashboard) | Indicates if the Cost Intelligence dashboard should be enabled | `bool` | `true` | no |
| <a name="input_enable_cudos_dashboard"></a> [enable\_cudos\_dashboard](#input\_enable\_cudos\_dashboard) | Indicates if the CUDOS dashboard should be enabled | `bool` | `false` | no |
| <a name="input_enable_cudos_v5_dashboard"></a> [enable\_cudos\_v5\_dashboard](#input\_enable\_cudos\_v5\_dashboard) | Indicates if the CUDOS V5 framework should be enabled | `bool` | `true` | no |
| <a name="input_enable_ecs_chargeback_module"></a> [enable\_ecs\_chargeback\_module](#input\_enable\_ecs\_chargeback\_module) | Indicates if the ECS Chargeback module should be enabled | `bool` | `false` | no |
| <a name="input_enable_health_events_module"></a> [enable\_health\_events\_module](#input\_enable\_health\_events\_module) | Indicates if the Health Events module should be enabled | `bool` | `true` | no |
| <a name="input_enable_inventory_module"></a> [enable\_inventory\_module](#input\_enable\_inventory\_module) | Indicates if the Inventory module should be enabled | `bool` | `true` | no |
| <a name="input_enable_kpi_dashboard"></a> [enable\_kpi\_dashboard](#input\_enable\_kpi\_dashboard) | Indicates if the KPI dashboard should be enabled | `bool` | `true` | no |
| <a name="input_enable_lake_formation"></a> [enable\_lake\_formation](#input\_enable\_lake\_formation) | Indicates if the Lake Formation should be enabled | `bool` | `false` | no |
| <a name="input_enable_license_manager_module"></a> [enable\_license\_manager\_module](#input\_enable\_license\_manager\_module) | Indicates if the License Manager module should be enabled | `bool` | `false` | no |
| <a name="input_enable_org_data_module"></a> [enable\_org\_data\_module](#input\_enable\_org\_data\_module) | Indicates if the Organization Data module should be enabled | `bool` | `true` | no |
| <a name="input_enable_prerequisites_quicksight"></a> [enable\_prerequisites\_quicksight](#input\_enable\_prerequisites\_quicksight) | Indicates if the prerequisites for QuickSight should be enabled | `bool` | `true` | no |
| <a name="input_enable_prerequisites_quicksight_permissions"></a> [enable\_prerequisites\_quicksight\_permissions](#input\_enable\_prerequisites\_quicksight\_permissions) | Indicates if the prerequisites for QuickSight permissions should be enabled | `bool` | `true` | no |
| <a name="input_enable_quicksight_admin"></a> [enable\_quicksight\_admin](#input\_enable\_quicksight\_admin) | Enable the creation of an admin user (var.quicksight\_admin\_username) in QuickSight | `bool` | `true` | no |
| <a name="input_enable_quicksight_subscription"></a> [enable\_quicksight\_subscription](#input\_enable\_quicksight\_subscription) | Enable QuickSight subscription | `bool` | `false` | no |
| <a name="input_enable_rds_utilization_module"></a> [enable\_rds\_utilization\_module](#input\_enable\_rds\_utilization\_module) | Indicates if the RDS Utilization module should be enabled | `bool` | `true` | no |
| <a name="input_enable_rightsizing_module"></a> [enable\_rightsizing\_module](#input\_enable\_rightsizing\_module) | Indicates if the Rightsizing module should be enabled | `bool` | `true` | no |
| <a name="input_enable_scad"></a> [enable\_scad](#input\_enable\_scad) | Indicates if the SCAD module should be enabled, only available when Cora enabled | `bool` | `false` | no |
| <a name="input_enable_sso"></a> [enable\_sso](#input\_enable\_sso) | Enable integration with identity center for QuickSight | `bool` | `true` | no |
| <a name="input_enable_tao_dashboard"></a> [enable\_tao\_dashboard](#input\_enable\_tao\_dashboard) | Indicates if the TAO dashboard should be enabled | `bool` | `false` | no |
| <a name="input_enable_tao_module"></a> [enable\_tao\_module](#input\_enable\_tao\_module) | Indicates if the TAO module should be enabled | `bool` | `true` | no |
| <a name="input_enable_transit_gateway_module"></a> [enable\_transit\_gateway\_module](#input\_enable\_transit\_gateway\_module) | Indicates if the Transit Gateway module should be enabled | `bool` | `true` | no |
| <a name="input_glue_data_catalog"></a> [glue\_data\_catalog](#input\_glue\_data\_catalog) | The name of the Glue data catalog | `string` | `"AwsDataCatalog"` | no |
| <a name="input_lambda_layer_bucket_prefix"></a> [lambda\_layer\_bucket\_prefix](#input\_lambda\_layer\_bucket\_prefix) | The prefix for the Lambda layer bucket | `string` | `"aws-managed-cost-intelligence-dashboards"` | no |
| <a name="input_payer_accounts"></a> [payer\_accounts](#input\_payer\_accounts) | List of additional payer accounts to be included in the collectors module | `list(string)` | `[]` | no |
| <a name="input_quicksight_admin_email"></a> [quicksight\_admin\_email](#input\_quicksight\_admin\_email) | The email address for the QuickSight admin user. Required if var.create\_quicksight\_admin\_user is true | `string` | `null` | no |
| <a name="input_quicksight_admin_username"></a> [quicksight\_admin\_username](#input\_quicksight\_admin\_username) | The username for the QuickSight admin user | `string` | `"admin"` | no |
| <a name="input_quicksight_dashboard_owner"></a> [quicksight\_dashboard\_owner](#input\_quicksight\_dashboard\_owner) | The username for the QuickSight user who will own the dashboards. This user needs to exist. By default, it will be the admin user which is created by the module. | `string` | `"admin"` | no |
| <a name="input_quicksight_data_set_refresh_schedule"></a> [quicksight\_data\_set\_refresh\_schedule](#input\_quicksight\_data\_set\_refresh\_schedule) | The schedule for the Quicksight data set refresh | `string` | `""` | no |
| <a name="input_quicksight_data_source_role_name"></a> [quicksight\_data\_source\_role\_name](#input\_quicksight\_data\_source\_role\_name) | The name of the Quicksight data source role | `string` | `"CidQuickSightDataSourceRole"` | no |
| <a name="input_quicksight_groups"></a> [quicksight\_groups](#input\_quicksight\_groups) | Map of groups with user membership to be added to QuickSight | <pre>map(object({<br/>    description = optional(string)<br/>    namespace   = optional(string)<br/>    members     = optional(list(string), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_quicksight_subscription_account_name"></a> [quicksight\_subscription\_account\_name](#input\_quicksight\_subscription\_account\_name) | The account name for the QuickSight quicksight\_subscription edition | `string` | `null` | no |
| <a name="input_quicksight_subscription_authentication_method"></a> [quicksight\_subscription\_authentication\_method](#input\_quicksight\_subscription\_authentication\_method) | The identity for the QuickSight quicksight\_subscription edition | `string` | `"IAM_AND_QUICKSIGHT"` | no |
| <a name="input_quicksight_subscription_edition"></a> [quicksight\_subscription\_edition](#input\_quicksight\_subscription\_edition) | The edition for the QuickSight quicksight\_subscription | `string` | `"ENTERPRISE"` | no |
| <a name="input_quicksight_subscription_email"></a> [quicksight\_subscription\_email](#input\_quicksight\_subscription\_email) | The email address for the QuickSight quicksight\_subscription edition | `string` | `null` | no |
| <a name="input_quicksight_users"></a> [quicksight\_users](#input\_quicksight\_users) | Map of user accounts to be registered in QuickSight | <pre>map(object({<br/>    identity_type = string<br/>    namespace     = optional(string, "default")<br/>    role          = optional(string, "READER")<br/>  }))</pre> | `{}` | no |
| <a name="input_saml_iam_role_name"></a> [saml\_iam\_role\_name](#input\_saml\_iam\_role\_name) | Name of the role all authentication users are initially given | `string` | `"aws-cudos-sso"` | no |
| <a name="input_saml_metadata"></a> [saml\_metadata](#input\_saml\_metadata) | The configuration for the SAML identity provider | `string` | `""` | no |
| <a name="input_saml_provider_name"></a> [saml\_provider\_name](#input\_saml\_provider\_name) | The name of the SAML provider | `string` | `"aws-cudos-sso"` | no |
| <a name="input_share_dashboard"></a> [share\_dashboard](#input\_share\_dashboard) | Indicates if the dashboard should be shared | `string` | `"yes"` | no |
| <a name="input_stack_name_cloud_intelligence"></a> [stack\_name\_cloud\_intelligence](#input\_stack\_name\_cloud\_intelligence) | The name of the CloudFormation stack to create the dashboards | `string` | `"CI-Cloud-Intelligence-Dashboards"` | no |
| <a name="input_stack_name_collectors"></a> [stack\_name\_collectors](#input\_stack\_name\_collectors) | The name of the CloudFormation stack to create the collectors | `string` | `"CidDataCollectionStack"` | no |
| <a name="input_stack_name_cora_data_exports"></a> [stack\_name\_cora\_data\_exports](#input\_stack\_name\_cora\_data\_exports) | The name of the CloudFormation stack to create the Data Exports | `string` | `"CidDataExportsDestinationStack"` | no |
| <a name="input_stack_name_data_exports"></a> [stack\_name\_data\_exports](#input\_stack\_name\_data\_exports) | The name of the CloudFormation stack to create the Data Exports | `string` | `"CidDataExportsDestinationStack"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cfn_dashboards_version"></a> [cfn\_dashboards\_version](#output\_cfn\_dashboards\_version) | The version of the CUDOS dashboards |
| <a name="output_cloudformation_bucket_arn"></a> [cloudformation\_bucket\_arn](#output\_cloudformation\_bucket\_arn) | The name of the bucket where to store the CloudFormation |
| <a name="output_dashboard_bucket_arn"></a> [dashboard\_bucket\_arn](#output\_dashboard\_bucket\_arn) | The name of the bucket where to store the dashboards |
| <a name="output_destination_bucket_arn"></a> [destination\_bucket\_arn](#output\_destination\_bucket\_arn) | The name of the bucket where to replicate the data from the CUR |
| <a name="output_destination_bucket_name"></a> [destination\_bucket\_name](#output\_destination\_bucket\_name) | The name of the bucket where to replicate the data from the CUR |
<!-- END_TF_DOCS -->
