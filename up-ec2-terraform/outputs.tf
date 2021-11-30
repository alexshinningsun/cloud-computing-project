output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.*.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.*.public_ip
}

output "pem_key" {
  description = "Private key of the EC2 instance"
  value       = tls_private_key.example.private_key_pem
}
