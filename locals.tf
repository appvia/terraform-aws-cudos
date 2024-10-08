
locals {
  ## The region where the stack is being deployed 
  region = data.aws_region.cost_analysis.name

  ## Is the account id for the cost analysis account 
  cost_analysis_account_id = data.aws_caller_identity.cost_analysis.account_id
  ## Is the management account id  
  management_account_id = data.aws_caller_identity.management.account_id
  ## Is the organization root id
  organization_root_id = data.aws_organizations_organization.current.roots[0].id
  ## The s3 bucket name for the cloudformation scripts 
  stacks_base_url = format("https://%s.s3.%s.amazonaws.com", var.stacks_bucket_name, local.region)
  ## Is the user mappings for the quicksight groups
  user_group_mappings = merge([
    for n, g in var.quicksight_groups : {
      for u in g.members :
      join("-", [n, u]) => {
        user  = u
        group = n
      }
    } if var.enable_sso
  ]...)

  ## Is the payer account id used in the collection configuration 
  payer_account_ids = distinct(sort(concat([local.management_account_id], var.additional_payer_accounts)))
}

