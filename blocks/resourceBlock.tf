resource "random_id" "randomness" {
  byte_length = 6
}

resource "aws_s3_bucket" "my-S3-bucket" {
  bucket = "my-new-bucket-alex-2023-${random_id.randomness.hex}"
  tags = {
    Name    = "My S3 Bucket"
    Purpose = "learning"
  }
}

resource "aws_security_group" "my-security-group" {
  name        = "https_inbound"
  description = "Allow inbound traffic on tcp/443"
  #vpc_id      = aws_vpc.vpc.id
  ingress {
    description = "Allow 443 from the Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "https_inbound"
    Purpose = "learning"
  }
}