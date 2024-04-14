
locals {
  ## Is the organization root id
  organization_root_id = data.aws_organizations_organization.current.roots[0].id
  ## Is the management account id  
  management_account_id = data.aws_organizations_organization.current.master_account_id
  ## Is the account id for the cost analysis account 
  cost_analysis_account_id = data.aws_caller_identity.cost_analysis.account_id
}

