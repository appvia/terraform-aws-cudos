
## Find the current identity for the cost analysis session 
data "aws_caller_identity" "current" {}

## Find the current region 
data "aws_region" "current" {}
