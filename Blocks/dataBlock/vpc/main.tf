#Retrieve the AWS region
data "aws_region" "current" {}

#Retrieve the list of AZs in the current AWS region
data "aws_availability_zones" "available" {}

# Retrieve ami
data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

locals {
  team        = "developers"
  application = "webapp"
  server_name = "ec2-${var.environment}-webapp-${var.sub_az}"
}

#Define the VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = var.vpc_name
    Environment = var.environment
    Region      = data.aws_region.current.name
  }
}

#Deploy the private subnets
resource "aws_subnet" "private_subnets" {
  for_each   = var.private_subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = tolist(data.aws_availability_zones.available.names)[
  each.value]
  tags = {
    Name = each.key
  }
}

#Deploy the public subnets
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value + 10)
  availability_zone       = tolist(data.aws_availability_zones.available.names)[each.value]
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
  }
}

resource "aws_instance" "webapp_server" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnets["public_subnet_1"].id
  tags = {
    Name  = local.server_name
    Owner = local.team
    App   = local.application
  }
}