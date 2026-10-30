module "vpc" {
  source = "./modules/vpc"

  vpc_name = "demo-vpc"
  vpc_cidr = "10.0.0.0/16"
}

module "subnet" {
  source = "./modules/subnet"

  vpc_id            = module.vpc.vpc_id
  subnet_cidr       = "10.0.1.0/24"
  subnet_name       = "demo-subnet"
  availability_zone = "us-east-1a"
}

module "prod-workload" {
  source = "./modules/ec2"

  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.subnet.subnet_id
  ami_id        = ami_12345
  instance_type = "t2.micro"
  instance_name = "bs-web-server"
}
