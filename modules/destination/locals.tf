locals {
  ## Is the account id for the cost analysis account
  account_id = data.aws_caller_identity.current.account_id
  ## Is the payer account id used in the collection configuration
  payer_account_ids = distinct(var.payer_accounts)
  ## The region where the stack is being deployed
  region = data.aws_region.current.name
  ## The URL for the s3 bucket containing cloudformation scripts
  bucket_url = format("https://%s.s3.%s.amazonaws.com", var.cloudformation_bucket_name, local.region)
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
}

