variable "environment" {
  description = "Environment for deployment"
  type        = string
  default     = "development"
}

variable "sub_az" {
  description = "Availability Zone used Variables Subnet"
  type        = string
  default     = "us-east-1a"
}
