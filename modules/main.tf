module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.7.3"

  name = var.vpc_name
  cidr = var.cidr_block
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  name   = "terraform-security-group"
  vpc_id = module.vpc.vpc_id
}

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.17.0"

  bucket_prefix = "${var.environment}-modules-lab-"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true

  versioning = {
    enabled = true
  }

  tags = {
    environment = var.environment
  }
}

module "s3_buckets" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.17.0"

  for_each = var.s3_buckets

  bucket_prefix = "${var.environment}-${each.key}-"

  tags = {
    name        = each.key
    environment = var.environment
  }
}
