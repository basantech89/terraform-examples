variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "subnet_id" {
  description = "The ID of the Subnet"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "The instance type to start"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "The instance name"
  type        = string
  default     = "my-instance"
}
