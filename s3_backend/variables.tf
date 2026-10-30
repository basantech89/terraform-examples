variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "main"
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for subnet"
  type        = string
  default     = "10.0.1.0/24"
}
