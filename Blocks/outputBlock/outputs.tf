output "webapp_server_ip" {
  description = "Public IP Address for EC2"
  value       = aws_instance.webapp_server.public_ip
  sensitive   = true
}

output "hello-world" {
  description = "Print a Hello World text output"
  value       = "Hello World"
}

output "vpc_id" {
  description = "Output the ID for  VPC"
  value       = aws_vpc.vpc.id
}