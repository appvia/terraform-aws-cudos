terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
      configuration_aliases = [
        aws.cost_analysis,
        aws.cost_analysis_us_east_1,
        aws.management,
        aws.management_us_east_1,
      ]
    }
  }
}
