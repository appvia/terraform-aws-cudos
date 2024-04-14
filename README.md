![Github Actions](../../actions/workflows/terraform.yml/badge.svg)

# Terraform AWS Cloud Intelligence Dashboards

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

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0  |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | ~> 5.0  |

## Providers

| Name                                                                                       | Version |
| ------------------------------------------------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws)                                           | ~> 5.0  |
| <a name="provider_aws.cost_analysis"></a> [aws.cost_analysis](#provider_aws.cost_analysis) | ~> 5.0  |
| <a name="provider_aws.management"></a> [aws.management](#provider_aws.management)          | ~> 5.0  |

## Modules

| Name                                                                                | Source                                                                                         | Version |
| ----------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- | ------- |
| <a name="module_collector"></a> [collector](#module_collector)                      | github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-destination | 0.2.47  |
| <a name="module_dashboard_bucket"></a> [dashboard_bucket](#module_dashboard_bucket) | terraform-aws-modules/s3-bucket/aws                                                            | 4.1.0   |
| <a name="module_dashboards"></a> [dashboards](#module_dashboards)                   | github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cid-dashboards        | 0.2.47  |
| <a name="module_source"></a> [source](#module_source)                               | github.com/aws-samples/aws-cudos-framework-deployment//terraform-modules/cur-setup-source      | 0.2.47  |

## Resources

| Name                                                                                                                                                | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_cloudformation_stack.cudos_data_collection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack)  | resource    |
| [aws_cloudformation_stack.cudos_read_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource    |
| [aws_iam_role.cudos_sso](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                      | resource    |
| [aws_iam_saml_provider.saml](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_saml_provider)                         | resource    |
| [aws_caller_identity.cost_analysis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                 | data source |
| [aws_iam_policy_document.cudos_sso](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)             | data source |
| [aws_iam_policy_document.cudos_sso_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |

## Inputs

| Name                                                                                                                                                               | Description                                                                 | Type          | Default                                   | Required |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------- | ------------- | ----------------------------------------- | :------: |
| <a name="input_dashbords_bucket_name"></a> [dashbords_bucket_name](#input_dashbords_bucket_name)                                                                   | The name of the bucket to store the dashboards configurations               | `string`      | n/a                                       |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                                                                      | Tags to apply to all resources                                              | `map(string)` | n/a                                       |   yes    |
| <a name="input_enable_compute_optimizer_dashboard"></a> [enable_compute_optimizer_dashboard](#input_enable_compute_optimizer_dashboard)                            | Indicates if the Compute Optimizer dashboard should be enabled              | `bool`        | `true`                                    |    no    |
| <a name="input_enable_cost_intelligence_dashboard"></a> [enable_cost_intelligence_dashboard](#input_enable_cost_intelligence_dashboard)                            | Indicates if the Cost Intelligence dashboard should be enabled              | `bool`        | `true`                                    |    no    |
| <a name="input_enable_cudos_dashboard"></a> [enable_cudos_dashboard](#input_enable_cudos_dashboard)                                                                | Indicates if the CUDOS dashboard should be enabled                          | `bool`        | `false`                                   |    no    |
| <a name="input_enable_cudos_v5_dashboard"></a> [enable_cudos_v5_dashboard](#input_enable_cudos_v5_dashboard)                                                       | Indicates if the CUDOS V5 framework should be enabled                       | `bool`        | `true`                                    |    no    |
| <a name="input_enable_kpi_dashboard"></a> [enable_kpi_dashboard](#input_enable_kpi_dashboard)                                                                      | Indicates if the KPI dashboard should be enabled                            | `bool`        | `true`                                    |    no    |
| <a name="input_enable_prerequisites_quicksight"></a> [enable_prerequisites_quicksight](#input_enable_prerequisites_quicksight)                                     | Indicates if the prerequisites for QuickSight should be enabled             | `bool`        | `true`                                    |    no    |
| <a name="input_enable_prerequisites_quicksight_permissions"></a> [enable_prerequisites_quicksight_permissions](#input_enable_prerequisites_quicksight_permissions) | Indicates if the prerequisites for QuickSight permissions should be enabled | `bool`        | `true`                                    |    no    |
| <a name="input_enable_sso"></a> [enable_sso](#input_enable_sso)                                                                                                    | Enable integration with identity center for QuickSight                      | `bool`        | `true`                                    |    no    |
| <a name="input_enable_tao_dashboard"></a> [enable_tao_dashboard](#input_enable_tao_dashboard)                                                                      | Indicates if the TAO dashboard should be enabled                            | `bool`        | `false`                                   |    no    |
| <a name="input_quicksights_username"></a> [quicksights_username](#input_quicksights_username)                                                                      | The username for the QuickSight user                                        | `string`      | `"admin"`                                 |    no    |
| <a name="input_saml_metadata"></a> [saml_metadata](#input_saml_metadata)                                                                                           | The configuration for the SAML identity provider                            | `string`      | `null`                                    |    no    |
| <a name="input_stack_name_cloud_intelligence"></a> [stack_name_cloud_intelligence](#input_stack_name_cloud_intelligence)                                           | The name of the CloudFormation stack to create the dashboards               | `string`      | `"CI-Cloud-Intelligence-Dashboards"`      |    no    |
| <a name="input_stack_name_collectors"></a> [stack_name_collectors](#input_stack_name_collectors)                                                                   | The name of the CloudFormation stack to create the collectors               | `string`      | `"CidDataCollectionStack"`                |    no    |
| <a name="input_stack_name_read_permissions"></a> [stack_name_read_permissions](#input_stack_name_read_permissions)                                                 | The name of the CloudFormation stack to create the collectors               | `string`      | `"CidDataCollectionReadPermissionsStack"` |    no    |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
