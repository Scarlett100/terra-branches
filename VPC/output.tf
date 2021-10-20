output "vpc_id" {
  value = aws_vpc.terra_vpc.id
}
output "route_table_id" {
  value = aws_route_table.example.id
}