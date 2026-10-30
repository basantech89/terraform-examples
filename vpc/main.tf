data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  name_prefix = "${var.environment}-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  tags = {
    Environment = var.environment
    Region      = data.aws_region.current.region
    Account     = data.aws_caller_identity.current.account_id
    CreatedBy   = "${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}"
    ManagedBy   = "Terraform"
  }
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.tags, {
    Name        = "main-vpc"
    Environment = var.environment
  })
}

resource "aws_subnet" "subnets" {
  for_each                = var.subnet_config
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = var.subnet_azs[each.key]
  map_public_ip_on_launch = true

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-${each.key}-subnet"
  })
}

resource "aws_s3_bucket" "app_buckets" {
  for_each = var.bucket_names
  bucket   = each.value

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-${each.value}-bucket"
  })
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "main-route-table"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.subnets["public"].id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.subnets["private"].id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "main" {
  name        = "main-security-group"
  description = "Main security group for the main VPC"
  vpc_id      = aws_vpc.main.id

  revoke_rules_on_delete = true

  tags = {
    Name        = "main-security-group"
    Environment = var.environment
  }
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
  description       = "Allow HTTP (80)"
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
  description       = "Allow HTTPS (443)"
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main.id
  description       = "Allow all outbound traffic"
}
