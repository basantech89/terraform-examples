data "aws_region" "current" {}

data "aws_vpc" "default-vpc" {
  default = true
}
