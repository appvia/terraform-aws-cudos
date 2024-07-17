
## Find the current identity for the cost analysis session 
data "aws_caller_identity" "cost_analysis" {
  provider = aws.cost_analysis
}

## Find the account id for the management account 
data "aws_caller_identity" "management" {
  provider = aws.management
}

## Find the current organization 
data "aws_organizations_organization" "current" {
  provider = aws.management
}
## Find the current region 
data "aws_region" "cost_analysis" {
  provider = aws.cost_analysis
}
