
provider "aws" {
  alias  = "cost_analysis"
  region = "eu-west-2"
}

provider "aws" {
  alias  = "management"
  region = "eu-west-2"
}
