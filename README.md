![Github Actions](../../actions/workflows/terraform.yml/badge.svg)

# Terraform AWS Cloud Intelligence Dashboards

<p align="center">
  <img src="docs/cudos.png" alt="CUDOS"/> 
</p>

## Description

The purpose of this module is to deploy the AWS Cloud Intelligence Dashboards (CUDOS) framework. The framework is a collection of dashboards that provide insights into your AWS environment. The dashboards are built using AWS QuickSight and are designed to provide insights into your AWS environment.

## Usage

Add example usage here

```hcl
module "cudos_framework" {
  source = "../.."

  dashbords_bucket_name              = var.dashboard_bucket_name
  enable_compute_optimizer_dashboard = true
  enable_cost_intelligence_dashboard = true
  enable_cudos_dashboard             = true
  enable_cudos_v5_dashboard          = true
  enable_kpi_dashboard               = true
  enable_sso                         = true
  enable_tao_dashboard               = false
  saml_metadata                      = file("${path.module}/assets/saml-metadata.xml")
  quicksights_username               = var.quicksights_username
  tags                               = var.tags

  providers = {
    aws.management              = aws.management
    aws.management_us_east_1    = aws.management_us_east_1
    aws.cost_analysis           = aws.cost_analysis
    aws.cost_analysis_us_east_1 = aws.cost_analysis_us_east_1
  }
}
```

## References

- [Identity Center integration](https://cloudyadvice.com/2022/04/29/implementing-cudos-cost-intelligence-dashboards-for-an-enterprise/)

## Update Documentation

The `terraform-docs` utility is used to generate this README. Follow the below steps to update:

1. Make changes to the `.terraform-docs.yml` file
2. Fetch the `terraform-docs` binary (https://terraform-docs.io/user-guide/installation/)
3. Run `terraform-docs markdown table --output-file ${PWD}/README.md --output-mode inject .`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_aws.cost_analysis"></a> [aws.cost\_analysis](#provider\_aws.cost\_analysis) | ~> 5.0 |
| <a name="provider_aws.management"></a> [aws.management](#provider\_aws.management) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_collector"></a> [collector](#module\_collector) | github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-destination | 0.3.1 |
| <a name="module_dashboard_bucket"></a> [dashboard\_bucket](#module\_dashboard\_bucket) | terraform-aws-modules/s3-bucket/aws | 4.1.2 |
| <a name="module_dashboards"></a> [dashboards](#module\_dashboards) | github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cid-dashboards | 0.3.1 |
| <a name="module_source"></a> [source](#module\_source) | github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-source | 0.3.1 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack.cudos_data_collection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_cloudformation_stack.cudos_read_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_iam_role.cudos_sso](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_saml_provider.saml](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider) | resource |
| [aws_caller_identity.cost_analysis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cudos_sso](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cudos_sso_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dashbords_bucket_name"></a> [dashbords\_bucket\_name](#input\_dashbords\_bucket\_name) | The name of the bucket to store the dashboards configurations | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | n/a | yes |
| <a name="input_enable_compute_optimizer_dashboard"></a> [enable\_compute\_optimizer\_dashboard](#input\_enable\_compute\_optimizer\_dashboard) | Indicates if the Compute Optimizer dashboard should be enabled | `bool` | `true` | no |
| <a name="input_enable_cost_intelligence_dashboard"></a> [enable\_cost\_intelligence\_dashboard](#input\_enable\_cost\_intelligence\_dashboard) | Indicates if the Cost Intelligence dashboard should be enabled | `bool` | `true` | no |
| <a name="input_enable_cudos_dashboard"></a> [enable\_cudos\_dashboard](#input\_enable\_cudos\_dashboard) | Indicates if the CUDOS dashboard should be enabled | `bool` | `false` | no |
| <a name="input_enable_cudos_v5_dashboard"></a> [enable\_cudos\_v5\_dashboard](#input\_enable\_cudos\_v5\_dashboard) | Indicates if the CUDOS V5 framework should be enabled | `bool` | `true` | no |
| <a name="input_enable_kpi_dashboard"></a> [enable\_kpi\_dashboard](#input\_enable\_kpi\_dashboard) | Indicates if the KPI dashboard should be enabled | `bool` | `true` | no |
| <a name="input_enable_prerequisites_quicksight"></a> [enable\_prerequisites\_quicksight](#input\_enable\_prerequisites\_quicksight) | Indicates if the prerequisites for QuickSight should be enabled | `bool` | `true` | no |
| <a name="input_enable_prerequisites_quicksight_permissions"></a> [enable\_prerequisites\_quicksight\_permissions](#input\_enable\_prerequisites\_quicksight\_permissions) | Indicates if the prerequisites for QuickSight permissions should be enabled | `bool` | `true` | no |
| <a name="input_enable_sso"></a> [enable\_sso](#input\_enable\_sso) | Enable integration with identity center for QuickSight | `bool` | `true` | no |
| <a name="input_enable_tao_dashboard"></a> [enable\_tao\_dashboard](#input\_enable\_tao\_dashboard) | Indicates if the TAO dashboard should be enabled | `bool` | `false` | no |
| <a name="input_quicksights_username"></a> [quicksights\_username](#input\_quicksights\_username) | The username for the QuickSight user | `string` | `"admin"` | no |
| <a name="input_saml_metadata"></a> [saml\_metadata](#input\_saml\_metadata) | The configuration for the SAML identity provider | `string` | `null` | no |
| <a name="input_stack_name_cloud_intelligence"></a> [stack\_name\_cloud\_intelligence](#input\_stack\_name\_cloud\_intelligence) | The name of the CloudFormation stack to create the dashboards | `string` | `"CI-Cloud-Intelligence-Dashboards"` | no |
| <a name="input_stack_name_collectors"></a> [stack\_name\_collectors](#input\_stack\_name\_collectors) | The name of the CloudFormation stack to create the collectors | `string` | `"CidDataCollectionStack"` | no |
| <a name="input_stack_name_read_permissions"></a> [stack\_name\_read\_permissions](#input\_stack\_name\_read\_permissions) | The name of the CloudFormation stack to create the collectors | `string` | `"CidDataCollectionReadPermissionsStack"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
