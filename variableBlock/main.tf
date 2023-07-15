resource "aws_subnet" "variables-subnet" {
  vpc_id                  = "vpc-0f395c1f5c3c739fc"
  cidr_block              = var.variables_sub_cidr
  availability_zone       = var.variables_sub_az
  map_public_ip_on_launch = var.variables_sub_auto_ip
  tags = {
    Name      = "subnet-${var.variables_sub_az}"
    Terraform = "true"
  }
}