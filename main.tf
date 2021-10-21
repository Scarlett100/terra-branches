provider "aws" {
  region = "eu-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "VPC" {
  source = "./VPC"

  vpc_cidr = "10.0.0.0/16"
  nat_gate = module.Subnets.nat_gate
}

module "Subnets" {
  source = "./Subnets"

  vpc_id             = module.VPC.vpc_id
  subnet_cidr        = "10.0.1.0/24"
  availability_zone  = "eu-west-1a"
  route_table_id     = module.VPC.route_table_id
  pri_route_table_id = module.VPC.pri_route_table_id
  internet_gate      = module.VPC.internet_gate
  av_zone_pri1       = "eu-west-1b"
  av_zone_pri2       = "eu-west-1c"
  cidr_pri1          = "10.0.2.0/24"
  cidr_pri2          = "10.0.3.0/24"
}

module "EC2" {
  source = "./EC2"

  instance_type          = "t2.micro"
  ami                    = "ami-0194c3e07668a7e36"
  key_name               = "terraforminit"
  availability_zone      = "eu-west-1a"
  subnet_id              = module.Subnets.subnet_id
  security_group         = module.Subnets.security_group
  instance_private_ip    = format("%s%s", substr(module.Subnets.subnet_cidr, 0, 7), "50") # I'm just having fun here, just makes 10.0.1.50
  db_password            = var.db_password
  private_security_group = module.Subnets.private_security_group
  subnet_group_name      = module.Subnets.subnet_group_name
  db_instance_class      = "db.t3.micro"
  initial_db_name        = "gameWorkshop"
}