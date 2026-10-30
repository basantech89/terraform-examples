resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "main-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name        = "public-subnet"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name        = "private-subnet"
    Environment = var.environment
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0b245cc5f82576748"
  instance_type = "t1.micro"
  subnet_id     = aws_subnet.private.id

  tags = {
    Name        = "web-server"
    Environment = var.environment
    Team        = "dev-app-001"
  }
}
