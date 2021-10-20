resource "aws_instance" "foo" {
  ami               = var.ami 
  instance_type     = var.instance_type
  key_name          = var.key_name
  availability_zone = var.availability_zone

  network_interface {
    network_interface_id = aws_network_interface.prod.id
    device_index         = 0
  }
}

resource "aws_network_interface" "prod" {
  subnet_id       = var.subnet_id
  private_ips     = [var.instance_private_ip]
  security_groups = [var.security_group]
}
