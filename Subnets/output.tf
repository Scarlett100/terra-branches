output "subnet_id" {
  value = aws_subnet.main.id
}
output "security_group" {
  value = aws_security_group.allow_ssh.id
}
output "subnet_cidr" {
  value = var.subnet_cidr
}