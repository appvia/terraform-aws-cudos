
locals {
  ## The region where the stack is being deployed 
  region = data.aws_region.current.name
  ## Is the management account id  
  management_account_id = data.aws_caller_identity.current.account_id
  ## Is the organization root id
  organization_root_id = data.aws_organizations_organization.current.roots[0].id
  ## The s3 bucket name for the cloudformation scripts 
  stacks_base_url = format("https://%s.s3.%s.amazonaws.com", var.stacks_bucket_name, local.region)
  ## The account id where the dashboard is being deployed 
  destination_account_id = var.destination_account_id
}
