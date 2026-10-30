variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "dev"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Availability zone for subnets"
  type        = string
  default     = "us-east-1a"
}

variable "subnet_config" {
  description = "Configuration for subnets"
  type        = map(string)
  default = {
    public   = "10.0.1.0/24"
    private  = "10.0.2.0/24"
    isolated = "10.0.3.0/24"
  }
}

variable "subnet_azs" {
  description = "Map of subnet availability zones"
  type        = map(string)
  default = {
    public   = "us-east-1a"
    private  = "us-east-1a"
    isolated = "us-east-1a"
  }
}

variable "bucket_names" {
  type    = set(string)
  default = ["bucket-1", "bucket-2", "bucket-3"]
}
