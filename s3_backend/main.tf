resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "${var.prefix}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr

  tags = {
    Name        = "${var.prefix}-subnet"
    Environment = var.environment
  }
}

resource "aws_security_group" "main" {
  name        = "${var.prefix}-main-sg"
  description = "Main security group"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name        = "${var.prefix}-main-sg"
    Environment = var.environment
    Purpose     = "Allow all inbound and outbound traffic"
  }
}
