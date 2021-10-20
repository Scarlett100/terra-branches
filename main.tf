provider "aws" {
  region = "eu-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "VPC" {
  source = "./VPC"

  vpc_cidr = "10.0.0.0/16"
}

module "Subnets" {
  source = "./Subnets"

  vpc_id            = module.VPC.vpc_id
  subnet_cidr       = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
  route_table_id    = module.VPC.route_table_id
}

module "EC2" {
  source = "./EC2"

  instance_type     = "t2.micro"
  ami               = "ami-0194c3e07668a7e36"
  key_name          = "terraforminit"
  availability_zone = "eu-west-2a"
  subnet_id         = module.Subnets.subnet_id
  security_group    = module.Subnets.security_group
  instance_private_ip = format("%s%s", substr(module.Subnets.subnet_cidr, 0, 7), "50") # I'm just having fun here, just makes 10.0.1.50
}