variable "private_subnets" {
  default = {
    "private_subnet_1" = 1
    "private_subnet_2" = 2
    "private_subnet_3" = 3
  }
}

variable "public_subnets" {
  default = {
    "public_subnet_1" = 1
    "public_subnet_2" = 2
    "public_subnet_3" = 3
  }
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "environment" {
  type    = string
  default = "development"
}

variable "vpc_name" {
  type    = string
  default = "my_vpc"
}

variable "sub_az" {
  description = "Availability Zone used for ec2 deployment"
  type        = string
  default     = "us-east-1a"
}

