
provider "aws" {
  alias  = "cost_analysis"
  region = "eu-west-2"
}

provider "aws" {
  alias  = "cost_analysis_us_east_1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "management"
  region = "eu-west-2"
}

provider "aws" {
  alias  = "management_us_east_1"
  region = "us-east-1"
}
