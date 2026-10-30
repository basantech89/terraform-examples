resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_subnet" "app" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = "${var.prefix}-subnet"
  }
}

import {
  to = aws_vpc.main
  id = "vpc-06a60d6b3a31badaf"
}

import {
  to = aws_subnet.app
  id = "subnet-0eebc9613f998b53c"
}

import {
  to = aws_security_group.main
  id = "sg-0a41bb2219c8d9212"
}
