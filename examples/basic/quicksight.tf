## QuickSight account subscription with IAM Identity Center authentication.
## Provision this in your pipeline before the destination module so dashboards
## deploy against an active QuickSight subscription and existing Identity Center users.
##

resource "aws_quicksight_account_subscription" "subscription" {
  account_name                     = var.quicksight_account_name
  authentication_method            = "IAM_IDENTITY_CENTER"
  edition                          = var.quicksight_edition
  notification_email               = var.quicksight_notification_email
  iam_identity_center_instance_arn = var.identity_center_instance_arn
  admin_group                      = [var.quicksight_admin_group]
  author_group                     = var.quicksight_author_groups
  reader_group                     = var.quicksight_reader_groups

  provider = aws.cost_analysis
}
