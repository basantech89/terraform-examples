variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "subnet_cidr" {
  type        = string
  description = "IP address of the subnet"
  default     = "10.0.1.0/24"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
  default     = "my-subnet"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for the subnet"
  default     = "us-east-1a"
}
