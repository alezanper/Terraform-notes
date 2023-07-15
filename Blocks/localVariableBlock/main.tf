locals {
  team        = "developers"
  application = "webapp"
  server_name = "ec2-${var.environment}-webapp-${var.sub_az}"
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "webapp_server" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t2.micro"
  # subnet_id     = aws_subnet.public_subnets["public_subnet_1"].id
  tags = {
    Name  = local.server_name
    Owner = local.team
    App   = local.application
  }
}