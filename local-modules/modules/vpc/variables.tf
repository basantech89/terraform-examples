variable "vpc_name" {
  type        = string
  description = "The name of the vpc"
  default     = "my-vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "IP address range for the vpc"
  default     = "10.0.0.0/16"
}
