
## Provision any groups within QuickSight
resource "aws_quicksight_group" "groups" {
  for_each = var.quicksight_groups

  description = each.value.description
  group_name  = each.key
  namespace   = each.value.namespace

  provider = aws.cost_analysis
}

## Provision any users within QuickSight 
resource "aws_quicksight_user" "users" {
  for_each = var.quicksight_users

  email         = each.key
  iam_arn       = each.value.identity_type == "IAM" ? aws_iam_role.cudos_sso[0].arn : null
  identity_type = each.value.identity_type
  namespace     = try(each.value.namespace, "default")
  session_name  = each.value.identity_type == "IAM" ? each.key : null
  user_name     = each.value.identity_type == "QUICKSIGHT" ? try(each.value.user_name, null) : null
  user_role     = try(each.value.role, null)

  provider = aws.cost_analysis
}

## Provision any group memberships within QuickSight
resource "aws_quicksight_group_membership" "members" {
  for_each = local.user_group_mappings

  group_name  = aws_quicksight_group.groups[each.value.group].group_name
  member_name = format("%s/%s", aws_iam_role.cudos_sso[0].name, each.value.user)

  depends_on = [aws_quicksight_user.users]

  provider = aws.cost_analysis
}
