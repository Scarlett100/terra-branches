output "subnet_id" {
  value = aws_subnet.main.id
}
output "security_group" {
  value = aws_security_group.allow_ssh.id
}
output "subnet_cidr" {
  value = var.subnet_cidr
}
output "nat_gate" {
  value = aws_nat_gateway.private_nat
}
output "subnet_group_name" {
  value = aws_db_subnet_group.private.name
}
output "private_security_group" {
  value = aws_security_group.allow_sql.id
}