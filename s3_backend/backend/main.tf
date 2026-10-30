terraform {
  required_version = ">= 1.16.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.65.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    # anytime this provider is used, these default tags will be applied to all resources created by this provider
    tags = {
      ManagedBy = "Terraform"
      Project   = "Terraform Testing"
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "state" {
  bucket = "main-tf-state-${data.aws_caller_identity.current.account_id}"

  force_destroy = true

  tags = {
    Name    = "main-tf-state"
    Purpose = "terraform-remote-state"
  }
}

resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id

  versioning_configuration {
    status = "Enabled"
  }
}

output "state_bucket_name" {
  description = "Name of the S3 bucket that stores terraform state"
  value       = aws_s3_bucket.state.bucket
}
