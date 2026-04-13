
locals {
  ## The region where the stack is being deployed
  region = data.aws_region.current.region
  ## Is the management account id
  management_account_id = data.aws_caller_identity.current.account_id
  ## The s3 bucket name for the cloudformation scripts
  stacks_base_url = format("https://%s.s3.%s.amazonaws.com", var.stacks_bucket_name, local.region)
  ## Hash of all CloudFormation templates to force stack updates when they change
  stacks_templates_hash = md5(join(",", [
    for template in sort(fileset("${path.module}/assets/cloudformation/", "**/*.yaml")) :
    format("%s:%s", template, filemd5("${path.module}/assets/cloudformation/${template}"))
  ]))
  ## Prefix used for versioned templates in S3
  stacks_templates_prefix = format("revisions/%s", local.stacks_templates_hash)
  ## The organization units where the dashboard is being deployed
  organizational_unit_ids = join(",", var.organizational_unit_ids)
  ## Indicate if the read permissions stack should be deployed
  enable_read_permissions = length(var.organizational_unit_ids) > 0
}

