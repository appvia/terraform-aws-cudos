locals {
  ## Is the account id for the cost analysis account
  account_id = data.aws_caller_identity.current.account_id
  ## Is the payer account id used in the collection configuration
  payer_account_ids = distinct(var.payer_accounts)
  ## The region where the stack is being deployed
  region = data.aws_region.current.region
  ## The URL for the s3 bucket containing cloudformation scripts
  stacks_base_url = format("https://%s.s3.%s.amazonaws.com", var.cloudformation_bucket_name, local.region)
  ## Hash of all CloudFormation templates to force stack updates when they change
  stacks_templates_hash = md5(join(",", [
    for template in sort(fileset("${path.module}/assets/cloudformation/", "**/*.yaml")) :
    format("%s:%s", template, filemd5("${path.module}/assets/cloudformation/${template}"))
  ]))
  ## Prefix used for versioned templates in S3
  stacks_templates_prefix = format("revisions/%s", local.stacks_templates_hash)
  ## Indicates if we should provision the quicksight admin user

  ## Is the user mappings for the quicksight groups - combined for both IAM and QuickSight users
  user_group_mappings = merge([
    for n, g in var.quicksight_groups : {
      for u in g.members :
      join("-", [n, u]) => {
        user          = u
        group         = n
        identity_type = var.quicksight_users[u].identity_type
      }
    }
  ]...)
  ## The base URL for the CUDOS dashboards
  cfn_dashboards_base_url = "https://aws-managed-cost-intelligence-dashboards.s3.amazonaws.com/cfn"
  ## The URL for the CUDOS dashboards
  cfn_dashboards_url = format("%s/${var.cfn_dashboards_version}/cid-cfn.yml", local.cfn_dashboards_base_url)
  ## The data collection bucket path
  data_collection_bucket = format("s3://cid-data-%s", local.account_id)
}
