<!-- BEGIN_TF_DOCS -->
## Providers

No providers.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dashboard_bucket_name"></a> [dashboard\_bucket\_name](#input\_dashboard\_bucket\_name) | The name of the bucket to store the dashboards | `string` | `"dashboard-bucket-dev"` | no |
| <a name="input_quicksights_username"></a> [quicksights\_username](#input\_quicksights\_username) | The username to use for QuickSight | `string` | `"admin"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | <pre>{<br/>  "Environment": "Production"<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->