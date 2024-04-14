<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |
| <a name="requirement_awscc"></a> [awscc](#requirement\_awscc) | >= 0.11.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cudos_framework"></a> [cudos\_framework](#module\_cudos\_framework) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cur_bucket_name"></a> [cur\_bucket\_name](#input\_cur\_bucket\_name) | The name of the bucket to store the CURs | `string` | `"cur-bucket-dev"` | no |
| <a name="input_dashboard_bucket_name"></a> [dashboard\_bucket\_name](#input\_dashboard\_bucket\_name) | The name of the bucket to store the dashboards | `string` | `"dashboard-bucket-dev"` | no |
| <a name="input_quicksights_username"></a> [quicksights\_username](#input\_quicksights\_username) | The username to use for QuickSight | `string` | `"admin"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | <pre>{<br>  "Environment": "Production"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->