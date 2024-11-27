
## Find the account id for the management account
data "aws_caller_identity" "current" {}

## Find the current region
data "aws_region" "current" {}
