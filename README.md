<!-- markdownlint-disable -->
<a href="https://www.appvia.io/"><img src="https://github.com/appvia/terraform-aws-cudos/blob/main/docs/banner.jpg?raw=true" alt="Appvia Banner"/></a><br/><p align="right"> <a href="https://registry.terraform.io/modules/appvia/cudos/aws/latest"><img src="https://img.shields.io/static/v1?label=APPVIA&message=Terraform%20Registry&color=191970&style=for-the-badge" alt="Terraform Registry"/></a></a> <a href="https://github.com/appvia/terraform-aws-cudos/releases/latest"><img src="https://img.shields.io/github/release/appvia/terraform-aws-cudos.svg?style=for-the-badge&color=006400" alt="Latest Release"/></a> <a href="https://appvia-community.slack.com/join/shared_invite/zt-1s7i7xy85-T155drryqU56emm09ojMVA#/shared-invite/email"><img src="https://img.shields.io/badge/Slack-Join%20Community-purple?style=for-the-badge&logo=slack" alt="Slack Community"/></a> <a href="https://github.com/appvia/terraform-aws-cudos/graphs/contributors"><img src="https://img.shields.io/github/contributors/appvia/terraform-aws-cudos.svg?style=for-the-badge&color=FF8C00" alt="Contributors"/></a>

<!-- markdownlint-restore -->
<!--
  ***** CAUTION: DO NOT EDIT ABOVE THIS LINE ******
-->

![Github Actions](https://github.com/appvia/terraform-aws-cudos/actions/workflows/terraform.yml/badge.svg)

# Terraform AWS Cloud Intelligence Dashboards

<p align="center">
  <img src="https://github.com/appvia/terraform-aws-cudos/blob/main/docs/cudos.png?raw=true" alt="CUDOS"/>
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

## Deployment Architecture

The following is taken from the Cloud Intelligence Dashboards framework, and depicts the deployment architecture:

<p align="center">
  <img src="https://github.com/appvia/terraform-aws-cudos/blob/main/docs/cid-deployment.png?raw=true" alt="Deployment Architecture"/>
</p>

## References

- [Identity Center integration](https://cloudyadvice.com/2022/04/29/implementing-cudos-cost-intelligence-dashboards-for-an-enterprise/)
- [CID Framework](https://github.com/awslabs/cid-framework)
- [CUDOS Deployment](https://github.com/aws-samples/aws-cudos-framework-deployment)

## Upgrading the dashboards

Due to the level of customization that can be done with the dashboards, it is recommended to follow the official documentation to upgrade the dashboards. The following steps are a general guide to upgrade the dashboards:

1. Download the latest version of `cid-cmd`, the instructions can be found [here](https://github.com/aws-samples/aws-cudos-framework-deployment?tab=readme-ov-file#install)
2. Run the `cic-cmd` command to upgrade the dashboards, selecting each of the dashboards that you want to upgrade.
3. Pay attention the Athena views, ensuring any customizations are not overwritten.

## Update Documentation

The `terraform-docs` utility is used to generate this README. Follow the below steps to update:

1. Make changes to the `.terraform-docs.yml` file
2. Fetch the `terraform-docs` binary (https://terraform-docs.io/user-guide/installation/)
3. Run `terraform-docs markdown table --output-file ${PWD}/README.md --output-mode inject .`account

## Enable Cora Data Exports

To enable the Cora Data Exports, please see https://catalog.workshops.aws/awscid/en-US/dashboards/additional/cora for more information, you simply have to enable the `var.enable_cora_data_exports`. This will deploy an additional [cloudformation](./assets/cloudformation/cudos/data-exports-aggregation.yaml) with the management account.

<!-- BEGIN_TF_DOCS -->
## Providers

No providers.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
