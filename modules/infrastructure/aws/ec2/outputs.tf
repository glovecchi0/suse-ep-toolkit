output "instances_private_ip" {
  value       = aws_instance.vm[0].private_ip
  description = "AWS EC2 Instances Private IPs"
}

output "instances_public_ip" {
  value       = aws_eip.static_ip.public_ip
  description = "AWS EC2 Instances Public IPs"
}

output "aws_security_group" {
  value = var.create_network_resources ? aws_security_group.sg[0].id : null
  description = "AWS Security group"
}

output "aws_subnet" {
  value = var.create_network_resources ? aws_subnet.public[0].id : null
  description = "AWS subnet"
}
