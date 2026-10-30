output "region" {
  value = data.aws_region.current.region
}

output "vpc_id" {
  value = data.aws_vpc.default-vpc.id
}
