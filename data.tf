## Find the current identity for the cost analysis session 
data "aws_caller_identity" "cost_analysis" {
  provider = aws.cost_analysis
}
## Find the current organization 
data "aws_organizations_organization" "current" {
  provider = aws.management
}

