terraform {
  required_version = ">= 1.16.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.68.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    # anytime this provider is used, these default tags will be applied to all resources created by this provider
    tags = {
      ManagedBy = "Terraform"
      Project   = "Terraform Testing"
    }
  }
}
