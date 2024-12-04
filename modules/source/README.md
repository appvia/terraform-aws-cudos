<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_destination_account_id"></a> [destination\_account\_id](#input\_destination\_account\_id) | The AWS account ID for the destination account | `string` | n/a | yes |
| <a name="input_destination_bucket_arn"></a> [destination\_bucket\_arn](#input\_destination\_bucket\_arn) | The ARN of the bucket where to replicate the data from the CUR | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | n/a | yes |
| <a name="input_enable_backup_module"></a> [enable\_backup\_module](#input\_enable\_backup\_module) | Indicates if the Backup module should be enabled | `bool` | `true` | no |
| <a name="input_enable_budgets_module"></a> [enable\_budgets\_module](#input\_enable\_budgets\_module) | Indicates if the Budget module should be enabled | `bool` | `true` | no |
| <a name="input_enable_compute_optimizer_module"></a> [enable\_compute\_optimizer\_module](#input\_enable\_compute\_optimizer\_module) | Indicates if the Compute Optimizer module should be enabled | `bool` | `true` | no |
| <a name="input_enable_compute_optimizization_hub"></a> [enable\_compute\_optimizization\_hub](#input\_enable\_compute\_optimizization\_hub) | Indicates if the Compute Optimizization Hub module should be enabled | `bool` | `false` | no |
| <a name="input_enable_cost_anomaly_module"></a> [enable\_cost\_anomaly\_module](#input\_enable\_cost\_anomaly\_module) | Indicates if the Cost Anomaly module should be enabled | `bool` | `true` | no |
| <a name="input_enable_curv1"></a> [enable\_curv1](#input\_enable\_curv1) | Indicates if the CURv1 module should be enabled (deprecated) | `bool` | `false` | no |
| <a name="input_enable_ecs_chargeback_module"></a> [enable\_ecs\_chargeback\_module](#input\_enable\_ecs\_chargeback\_module) | Indicates if the ECS Chargeback module should be enabled | `bool` | `false` | no |
| <a name="input_enable_health_events_module"></a> [enable\_health\_events\_module](#input\_enable\_health\_events\_module) | Indicates if the Health Events module should be enabled | `bool` | `true` | no |
| <a name="input_enable_inventory_module"></a> [enable\_inventory\_module](#input\_enable\_inventory\_module) | Indicates if the Inventory module should be enabled | `bool` | `true` | no |
| <a name="input_enable_rds_utilization_module"></a> [enable\_rds\_utilization\_module](#input\_enable\_rds\_utilization\_module) | Indicates if the RDS Utilization module should be enabled | `bool` | `true` | no |
| <a name="input_enable_rightsizing_module"></a> [enable\_rightsizing\_module](#input\_enable\_rightsizing\_module) | Indicates if the Rightsizing module should be enabled | `bool` | `true` | no |
| <a name="input_enable_scad"></a> [enable\_scad](#input\_enable\_scad) | Indicates if the SCAD module should be enabled, only available when Cora enabled | `bool` | `false` | no |
| <a name="input_enable_tao_module"></a> [enable\_tao\_module](#input\_enable\_tao\_module) | Indicates if the TAO module should be enabled | `bool` | `true` | no |
| <a name="input_enable_transit_gateway_module"></a> [enable\_transit\_gateway\_module](#input\_enable\_transit\_gateway\_module) | Indicates if the Transit Gateway module should be enabled | `bool` | `true` | no |
| <a name="input_organizational_unit_ids"></a> [organizational\_unit\_ids](#input\_organizational\_unit\_ids) | List of organization units where the read permissions stack will be deployed | `list(string)` | `[]` | no |
| <a name="input_stack_name_data_exports_source"></a> [stack\_name\_data\_exports\_source](#input\_stack\_name\_data\_exports\_source) | The name of the CloudFormation stack to create the Data Exports | `string` | `"CidDataExportsSourceStack"` | no |
| <a name="input_stack_name_read_permissions"></a> [stack\_name\_read\_permissions](#input\_stack\_name\_read\_permissions) | The name of the CloudFormation stack to create the collectors | `string` | `"CidDataCollectionReadPermissionsStack"` | no |
| <a name="input_stacks_bucket_name"></a> [stacks\_bucket\_name](#input\_stacks\_bucket\_name) | The name of the bucket to store the CloudFormation templates | `string` | `"cid-cloudformation-templates"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudformation_bucket_name"></a> [cloudformation\_bucket\_name](#output\_cloudformation\_bucket\_name) | The name of the bucket to store the CloudFormation templates |
| <a name="output_cloudformation_bucket_url"></a> [cloudformation\_bucket\_url](#output\_cloudformation\_bucket\_url) | The URL of the bucket to store the CloudFormation templates |
| <a name="output_management_account_id"></a> [management\_account\_id](#output\_management\_account\_id) | The AWS account ID for the management account |
<!-- END_TF_DOCS -->