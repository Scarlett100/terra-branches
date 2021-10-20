resource "aws_vpc" "terra_vpc" {
  cidr_block       = var.vpc_cidr

  tags = {
    Name = "production"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "production"
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.terra_vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.gw.id
    }

  route {
      ipv6_cidr_block        = "::/0"
      gateway_id = aws_internet_gateway.gw.id
    }

  tags = {
    Name = "production"
  }
}