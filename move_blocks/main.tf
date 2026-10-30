resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "${var.prefix}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "subnets" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = "${var.prefix}-subnet"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.prefix}-rt"
    Environment = var.environment
  }
}

resource "aws_security_group" "app" {
  name        = "${var.prefix}-web-sg"
  description = "Main security group for the main VPC"
  vpc_id      = aws_vpc.main.id

  revoke_rules_on_delete = true

  tags = {
    Name        = "${var.prefix}-web-sg"
    Environment = var.environment
  }
}

moved {
  from = aws_security_group.main
  to   = aws_security_group.app
}

removed {
  from = aws_subnet.subnets

  lifecycle {
    destroy = false
  }
}
