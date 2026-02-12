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

**Problem**: Organizations struggle with AWS cost visibility and optimization across multi-account environments. Manual cost analysis is time-consuming, lacks standardization, and fails to provide actionable insights into spending patterns, resource utilization, and optimization opportunities.

**Solution**: This Terraform module automates the deployment of AWS Cloud Intelligence Dashboards (CID) framework across your AWS Organization. It provisions a complete cost intelligence platform using AWS QuickSight, delivering pre-built dashboards that transform raw billing data into actionable insights for cost optimization, chargeback/showback, and resource rightsizing.

**Architecture Overview**: The module operates across two AWS accounts using a hub-and-spoke architecture:
- **Source (Management Account)**: Deploys data collection modules via CloudFormation StackSets, gathering cost, usage, and operational data from across your organization
- **Destination (Cost Analysis Account)**: Provisions QuickSight dashboards, Athena views, S3 storage, and data collection orchestration

The framework integrates with AWS Cost and Usage Reports (CUR 2.0), AWS Data Exports, and various AWS services to collect metrics on backups, budgets, compute optimizer recommendations, ECS workloads, health events, inventory, RDS utilization, and more.

**Multi-Account Strategy**: Designed for AWS Organizations with centralized billing. The module assumes you have:
- A management account (payer account) for organization-wide data collection
- A dedicated cost analysis account for QuickSight and dashboard hosting
- Optional: AWS Identity Center (formerly SSO) for dashboard access control

## Features

### Security by Default
- **Encrypted Storage**: AES-256 encryption on all S3 buckets for CloudFormation templates and dashboard configurations
- **Private Buckets**: Public access blocks enabled on all storage resources
- **IAM Least Privilege**: Scoped permissions for QuickSight data source access and cross-account data collection
- **SAML Federation**: Native integration with AWS Identity Center for centralized authentication

### Flexible Deployment Options
- **Modular Dashboard Selection**: Enable/disable individual dashboards (CUDOS v5, Cost Intelligence, KPI, TAO, Compute Optimizer)
- **Granular Data Collection**: Toggle specific modules (backup, budgets, ECS chargeback, health events, inventory, RDS utilization, rightsizing, transit gateway)
- **CUR Format Support**: Compatible with both legacy CUR and modern AWS Data Exports (CUR 2.0, FOCUS)
- **QuickSight Editions**: Support for both Enterprise and Standard editions with configurable user management

### Operational Excellence
- **CloudFormation Integration**: Uses official AWS CID framework CloudFormation templates for dashboard provisioning
- **Automated Data Collection**: Scheduled Lambda functions collect operational data across your organization
- **Version Management**: S3 lifecycle policies automatically clean up old template versions after 90 days
- **Cross-Region Support**: Handles services that require us-east-1 deployment (QuickSight, CUR)

### Cost Intelligence Capabilities
- **Comprehensive Dashboards**: CUDOS (Cost & Usage), Cost Intelligence, KPI, Trusted Advisor Organizational view, Compute Optimizer
- **Chargeback/Showback**: Tag-based cost allocation with configurable primary and secondary tags
- **Optimization Insights**: Integration with AWS Compute Optimizer, Trusted Advisor, and rightsizing recommendations
- **Anomaly Detection**: Cost anomaly alerts and budget tracking across accounts

## Usage

### Basic Deployment (Golden Path)

The most common configuration for organizations starting with Cloud Intelligence Dashboards. This deploys core dashboards with SSO integration.

```hcl
module "cloud_intelligence" {
  source = "appvia/cudos/aws"

  # Destination account configuration (Cost Analysis/QuickSight)
  module "destination" {
    source = "appvia/cudos/aws//modules/destination"

    cloudformation_bucket_name = "my-org-cid-cloudformation"
    dashboards_bucket_name     = "my-org-cid-dashboards"

    # Enable SSO integration
    enable_sso    = true
    saml_metadata = file("${path.module}/saml-metadata.xml")

    # Core dashboards
    enable_cudos_v5_dashboard          = true
    enable_cost_intelligence_dashboard = true
    enable_kpi_dashboard               = true
    enable_compute_optimizer_dashboard = true

    # QuickSight admin user
    quicksight_admin_email     = "finance-team@example.com"
    quicksight_admin_username  = "admin"
    quicksight_dashboard_owner = "admin"

    # Management account IDs for data collection
    payer_accounts = ["123456789012"]

    tags = {
      Environment = "production"
      ManagedBy   = "terraform"
      CostCenter  = "finance"
    }

    providers = {
      aws           = aws.cost_analysis
      aws.us_east_1 = aws.cost_analysis_us_east_1
    }
  }

  # Source account configuration (Management/Payer)
  module "source" {
    source = "appvia/cudos/aws//modules/source"

    destination_account_id = "987654321098"  # Cost analysis account ID
    destination_bucket_arn = module.destination.destination_bucket_arn
    stacks_bucket_name     = "my-org-cid-cloudformation"

    # Enable core data collection modules
    enable_backup_module          = true
    enable_budgets_module         = true
    enable_inventory_module       = true
    enable_rds_utilization_module = true

    tags = {
      Environment = "production"
      ManagedBy   = "terraform"
    }

    providers = {
      aws           = aws.management
      aws.us_east_1 = aws.management_us_east_1
    }
  }
}
```

### Advanced Deployment (Power User)

This configuration enables all available modules, custom QuickSight user management, and ECS chargeback capabilities.

```hcl
locals {
  payer_account_id     = "123456789012"
  cost_analysis_account = "987654321098"

  common_tags = {
    Environment = "production"
    ManagedBy   = "terraform"
    Project     = "cost-intelligence"
    Owner       = "finops-team"
  }
}

module "destination" {
  source = "appvia/cudos/aws//modules/destination"

  cloudformation_bucket_name = "acme-corp-cid-cloudformation"
  dashboards_bucket_name     = "acme-corp-cid-dashboards"

  # Enable all dashboards
  enable_cudos_v5_dashboard          = true
  enable_cost_intelligence_dashboard = true
  enable_kpi_dashboard               = true
  enable_tao_dashboard               = true
  enable_compute_optimizer_dashboard = true

  # Enable all data collection modules
  enable_backup_module             = true
  enable_budgets_module            = true
  enable_compute_optimizer_module  = true
  enable_cost_anomaly_module       = true
  enable_ecs_chargeback_module     = true
  enable_health_events_module      = true
  enable_inventory_module          = true
  enable_license_manager_module    = true
  enable_rds_utilization_module    = true
  enable_rightsizing_module        = true
  enable_transit_gateway_module    = true
  enable_tao_module                = true
  enable_org_data_module           = true

  # Advanced features
  enable_scad                        = true  # Savings with Cost Anomaly Detection
  enable_compute_optimization_hub    = true
  enable_lake_formation              = false

  # Tag-based chargeback configuration
  data_collection_primary_tag_name   = "CostCenter"
  data_collection_secondary_tag_name = "Environment"

  # Custom QuickSight configuration
  enable_sso                  = true
  saml_metadata               = file("${path.module}/identity-center-metadata.xml")
  saml_provider_name          = "identity-center"
  saml_iam_role_name          = "QuickSight-SSO-Role"
  quicksight_admin_email      = "cloud-finops@acme-corp.com"
  quicksight_admin_username   = "finops-admin"
  quicksight_dashboard_owner  = "finops-admin"

  # QuickSight user management
  quicksight_users = {
    "john.doe@acme-corp.com" = {
      identity_type = "QUICKSIGHT"
      role          = "AUTHOR"
    }
    "jane.smith@acme-corp.com" = {
      identity_type = "QUICKSIGHT"
      role          = "READER"
    }
  }

  quicksight_groups = {
    "finance-team" = {
      description = "Finance and FinOps team members"
      members     = ["john.doe@acme-corp.com", "jane.smith@acme-corp.com"]
    }
  }

  # Athena configuration
  athena_workgroup             = "cid-workgroup"
  database_name                = "cid_database"
  quicksight_data_set_refresh_schedule = "0 6 * * ? *"  # Daily at 6 AM UTC

  payer_accounts = [local.payer_account_id]
  tags           = local.common_tags

  providers = {
    aws           = aws.cost_analysis
    aws.us_east_1 = aws.cost_analysis_us_east_1
  }
}

module "source" {
  source = "appvia/cudos/aws//modules/source"

  destination_account_id = local.cost_analysis_account
  destination_bucket_arn = module.destination.destination_bucket_arn
  stacks_bucket_name     = "acme-corp-cid-cloudformation"

  # Match destination module settings
  enable_backup_module             = true
  enable_budgets_module            = true
  enable_compute_optimizer_module  = true
  enable_cost_anomaly_module       = true
  enable_ecs_chargeback_module     = true
  enable_health_events_module      = true
  enable_inventory_module          = true
  enable_rds_utilization_module    = true
  enable_rightsizing_module        = true
  enable_transit_gateway_module    = true
  enable_tao_module                = true
  enable_scad                      = true

  # Deploy to specific OUs (optional)
  organizational_unit_ids = ["ou-xxxx-yyyyyyyy", "ou-xxxx-zzzzzzzz"]

  # Data export configuration
  enable_cur2        = true
  enable_focus       = false
  time_granularity   = "HOURLY"
  resource_prefix    = "cid"

  tags = local.common_tags

  providers = {
    aws           = aws.management
    aws.us_east_1 = aws.management_us_east_1
  }
}
```

### Migration Scenario (Existing Infrastructure)

Deploying CID alongside existing cost management tools with custom bucket names and settings.

```hcl
# Import existing QuickSight subscription before applying
# terraform import module.destination.aws_quicksight_account_subscription.subscription[0] <aws-account-id>

module "destination" {
  source = "appvia/cudos/aws//modules/destination"

  # Use existing S3 buckets
  cloudformation_bucket_name = "existing-cloudformation-bucket"
  dashboards_bucket_name     = "existing-dashboard-configs"

  # Disable QuickSight subscription creation (already exists)
  enable_quicksight_subscription = false

  # Disable admin user creation (using existing users)
  enable_quicksight_admin = false
  quicksight_dashboard_owner = "existing-admin-user"

  # Enable selective dashboards
  enable_cudos_v5_dashboard = true
  enable_kpi_dashboard      = true

  # Disable SSO (using existing IAM/QuickSight auth)
  enable_sso = false

  # Custom CloudFormation stack names to avoid conflicts
  stack_name_cloud_intelligence = "Custom-CID-Dashboards"
  stack_name_collectors         = "Custom-CID-Collectors"
  stack_name_data_exports       = "Custom-CID-DataExports"

  # Use custom dashboard version
  cfn_dashboards_version = "4.3.7"

  payer_accounts = ["123456789012"]

  tags = {
    ManagedBy = "terraform"
    Migration = "from-manual-deployment"
  }

  providers = {
    aws           = aws.cost_analysis
    aws.us_east_1 = aws.cost_analysis_us_east_1
  }
}

module "source" {
  source = "appvia/cudos/aws//modules/source"

  destination_account_id = "987654321098"
  destination_bucket_arn = module.destination.destination_bucket_arn
  stacks_bucket_name     = "existing-cloudformation-bucket"

  # Custom stack names
  stack_name_data_exports_source = "Custom-CID-DataExportsSource"
  stack_name_read_permissions    = "Custom-CID-ReadPermissions"

  # Minimal data collection during migration
  enable_backup_module   = false
  enable_budgets_module  = true
  enable_inventory_module = true

  tags = {
    ManagedBy = "terraform"
    Migration = "from-manual-deployment"
  }

  providers = {
    aws           = aws.management
    aws.us_east_1 = aws.management_us_east_1
  }
}
```

## Deployment Architecture

The module implements a hub-and-spoke architecture across AWS accounts:

<p align="center">
  <img src="https://github.com/appvia/terraform-aws-cudos/blob/main/docs/cid-deployment.png?raw=true" alt="Deployment Architecture"/>
</p>

**Data Flow**:
1. **Management Account**: AWS Organizations data, CUR/Data Exports, and cross-account data collection via Lambda functions
2. **Member Accounts**: Data collectors deploy via StackSets to gather resource-specific metrics
3. **Cost Analysis Account**: Centralized S3 storage, Athena views, Glue catalog, and QuickSight dashboards
4. **End Users**: Access dashboards via QuickSight (authenticated through IAM or AWS Identity Center)

## Operational Considerations

### Prerequisites
- **AWS Organizations**: Must be enabled with consolidated billing
- **CUR/Data Exports**: Cost and Usage Report or AWS Data Exports (CUR 2.0) must be configured
- **QuickSight**: Enterprise edition required for Identity Center integration; Standard edition supports IAM-only auth
- **IAM Permissions**: Deploying account needs `cloudformation:*`, `quicksight:*`, `s3:*`, `iam:*`, `lambda:*` permissions
- **Cross-Account Access**: Management account must trust cost analysis account for S3 data replication

### Deployment Time
- **Initial Deployment**: 30-45 minutes (includes CloudFormation stack creation, QuickSight resource provisioning, and Athena view setup)
- **Dashboard Availability**: QuickSight dashboards may take an additional 10-15 minutes after infrastructure provisioning for initial data ingestion
- **Data Refresh**: Lambda-based collectors run hourly/daily depending on the module; full historical data population can take 24-48 hours

### Known Limitations
- **QuickSight Region**: QuickSight must be enabled in the same region as your Athena workgroup (typically us-east-1 or your primary region)
- **CUR Lag**: Cost and Usage Report data has a 24-hour delay; current-day costs are estimates
- **Data Export Regions**: AWS Data Exports (CUR 2.0) are currently limited to specific regions; check AWS documentation for availability
- **SPICE Capacity**: QuickSight SPICE (in-memory engine) has capacity limits; Enterprise edition required for larger datasets
- **Module Dependencies**: Some data collection modules require specific AWS services to be enabled (e.g., AWS Backup, Compute Optimizer, Trusted Advisor)
- **StackSet Deployment**: Cross-account data collection uses CloudFormation StackSets; requires service-managed or self-managed StackSet permissions

### Cost Considerations
- **QuickSight Licensing**: Enterprise edition costs $18/user/month (or $5/reader/month); Standard edition is $9/user/month
- **Athena Queries**: Charged per TB scanned; optimize with partitioning and date filters
- **Lambda Invocations**: Data collectors run on schedules; costs typically $10-50/month depending on org size
- **S3 Storage**: Dashboard configurations and CloudFormation templates; typically <1GB ($0.02/month)
- **Data Transfer**: Cross-account S3 replication may incur transfer costs if accounts are in different regions

### Security Considerations
- **SAML Metadata**: Store SAML metadata files in a secure location; they contain sensitive IdP configuration
- **Bucket Policies**: The module uses least-privilege bucket policies; review before deployment in regulated environments
- **QuickSight VPC**: QuickSight Enterprise supports VPC connections; configure via `enable_lake_formation` for private Athena access
- **CloudFormation Drift**: Dashboards deployed via CloudFormation may drift if modified manually in QuickSight; use `cid-cmd` CLI for updates

## Upgrading Dashboards

Dashboard definitions are managed by AWS via CloudFormation templates. To upgrade to newer dashboard versions:

1. **Install cid-cmd CLI**: Download the latest version of the official [CID command-line tool](https://github.com/aws-samples/aws-cudos-framework-deployment?tab=readme-ov-file#install)
   ```bash
   python3 -m pip install --upgrade cid-cmd
   ```

2. **Run Dashboard Upgrade**: Execute the CLI to select and upgrade specific dashboards
   ```bash
   cid-cmd upgrade
   ```

3. **Review Athena Views**: Inspect Athena views for custom modifications before confirming upgrades to avoid overwriting customizations

4. **Update Terraform Variable**: After upgrading, update the `cfn_dashboards_version` variable to match the deployed version for state consistency
   ```hcl
   cfn_dashboards_version = "4.4.0"  # Update to match cid-cmd deployment
   ```

**Note**: Dashboard schema changes may require re-creating QuickSight datasets. Test upgrades in a non-production environment first.

## Advanced Features

### SCAD (Savings with Cost Anomaly Detection)
Enable SCAD for ML-powered cost anomaly detection integrated with CUDOS dashboards:
```hcl
enable_scad = true  # In both source and destination modules
```

Requires AWS Data Exports (CUR 2.0) to be enabled. See the [AWS CID Workshop](https://catalog.workshops.aws/awscid/en-US/dashboards/additional/cora) for details.

### Compute Optimization Hub
Centralized compute rightsizing recommendations across EC2, Lambda, and ECS:
```hcl
enable_compute_optimization_hub = true
enable_compute_optimizer_module = true
```

### Tag-Based Chargeback
Configure custom tags for cost allocation and showback reporting:
```hcl
data_collection_primary_tag_name   = "CostCenter"
data_collection_secondary_tag_name = "Project"
```

Dashboards will group costs by specified tags, enabling department-level chargeback.

### AWS License Manager Integration
Track license usage alongside infrastructure costs:
```hcl
enable_license_manager_module = true
```

Requires AWS License Manager to be configured with license rules.

## Troubleshooting

### QuickSight User Not Found
**Error**: `User 'admin' does not exist in QuickSight`

**Resolution**: Ensure QuickSight subscription is active and user is created before deploying dashboards. Set `enable_quicksight_admin = true` and provide `quicksight_admin_email`.

### CloudFormation Stack Timeout
**Error**: Stack creation exceeds 60-minute timeout

**Resolution**: Increase timeout in `timeouts` block or deploy dashboards incrementally by disabling some initially:
```hcl
enable_cudos_v5_dashboard = true
enable_tao_dashboard      = false  # Deploy in second phase
```

### Athena Query Permissions Error
**Error**: `Insufficient permissions to access S3 bucket`

**Resolution**: Verify `destination_bucket_arn` is correctly passed from destination to source module and cross-account bucket policies allow management account access.

### SSO Integration Failure
**Error**: `SAML provider already exists`

**Resolution**: If migrating from manual deployment, import existing SAML provider:
```bash
terraform import 'module.destination.aws_iam_saml_provider.saml[0]' arn:aws:iam::ACCOUNT_ID:saml-provider/PROVIDER_NAME
```

## Provider Configuration

This module requires four AWS provider configurations for cross-account and cross-region deployments:

```hcl
# Management account (primary region)
provider "aws" {
  alias  = "management"
  region = "us-west-2"

  assume_role {
    role_arn = "arn:aws:iam::123456789012:role/OrganizationAccountAccessRole"
  }
}

# Management account (us-east-1 for CUR/Data Exports)
provider "aws" {
  alias  = "management_us_east_1"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::123456789012:role/OrganizationAccountAccessRole"
  }
}

# Cost analysis account (primary region)
provider "aws" {
  alias  = "cost_analysis"
  region = "us-west-2"

  assume_role {
    role_arn = "arn:aws:iam::987654321098:role/CostAnalysisRole"
  }
}

# Cost analysis account (us-east-1 for QuickSight)
provider "aws" {
  alias  = "cost_analysis_us_east_1"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::987654321098:role/CostAnalysisRole"
  }
}
```

## References

- [AWS Cloud Intelligence Dashboards Workshop](https://catalog.workshops.aws/awscid/)
- [Identity Center Integration Guide](https://cloudyadvice.com/2022/04/29/implementing-cudos-cost-intelligence-dashboards-for-an-enterprise/)
- [Official CID Framework](https://github.com/awslabs/cid-framework)
- [CID Command-Line Tool](https://github.com/aws-samples/aws-cudos-framework-deployment)
- [AWS Cost and Usage Reports Documentation](https://docs.aws.amazon.com/cur/latest/userguide/what-is-cur.html)

## Update Documentation

This README is generated using [terraform-docs](https://terraform-docs.io/). The Providers, Inputs, and Outputs sections are automatically generated.

To update the README:
1. Modify the `.terraform-docs.yml` configuration file
2. Install terraform-docs: `brew install terraform-docs` (macOS) or download from [releases](https://github.com/terraform-docs/terraform-docs/releases)
3. Run: `terraform-docs markdown table --output-file README.md --output-mode inject .`

Manual edits should be made above the `<!-- BEGIN_TF_DOCS -->
## Providers

No providers.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
