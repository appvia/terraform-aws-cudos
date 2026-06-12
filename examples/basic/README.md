<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.cost_analysis"></a> [aws.cost\_analysis](#provider\_aws.cost\_analysis) | >= 6.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_identity_center_instance_arn"></a> [identity\_center\_instance\_arn](#input\_identity\_center\_instance\_arn) | ARN of the IAM Identity Center instance. When null, the first instance returned by aws\_ssoadmin\_instances is used. | `string` | `null` | no |
| <a name="input_quicksight_account_name"></a> [quicksight\_account\_name](#input\_quicksight\_account\_name) | Display name for the QuickSight account subscription | `string` | `"cid-quicksight"` | no |
| <a name="input_quicksight_admin_group"></a> [quicksight\_admin\_group](#input\_quicksight\_admin\_group) | IAM Identity Center group name with QuickSight admin permissions. Required when authentication\_method is IAM\_IDENTITY\_CENTER. | `string` | `"CID-QuickSight-Admins"` | no |
| <a name="input_quicksight_author_groups"></a> [quicksight\_author\_groups](#input\_quicksight\_author\_groups) | IAM Identity Center group names to grant QuickSight author permissions | `list(string)` | <pre>[<br/>  "CID-QuickSight-Authors"<br/>]</pre> | no |
| <a name="input_quicksight_edition"></a> [quicksight\_edition](#input\_quicksight\_edition) | QuickSight edition. IAM Identity Center requires ENTERPRISE or ENTERPRISE\_AND\_Q. | `string` | `"ENTERPRISE"` | no |
| <a name="input_quicksight_notification_email"></a> [quicksight\_notification\_email](#input\_quicksight\_notification\_email) | Email address for QuickSight subscription notifications | `string` | `"quicksight-admin@example.com"` | no |
| <a name="input_quicksight_reader_groups"></a> [quicksight\_reader\_groups](#input\_quicksight\_reader\_groups) | IAM Identity Center group names to grant QuickSight reader permissions | `list(string)` | <pre>[<br/>  "CID-QuickSight-Readers"<br/>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | <pre>{<br/>  "Environment": "Production"<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
