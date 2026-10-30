variable "cidr_block" {
  type        = string
  description = "IP address range for the vpc"
  default     = "192.168.0.0/16"
}

variable "vpc_name" {
  type        = string
  description = "The name of the vpc"
  default     = "terraform-vpc"
}

variable "environment" {
  type        = string
  description = "Environment"
  default     = "development"
}

variable "region" {
  type        = string
  description = "The default region"
  default     = "us-east-1"
}

variable "s3_buckets" {
  description = "Map of S3 buckets to create"
  type        = map(string)
  default = {
    "logs"      = "Store application logs"
    "artifacts" = "Store build artifacts"
    "configs"   = "Store application config"
  }
}
