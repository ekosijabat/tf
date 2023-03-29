module "pairs" {
  source = "../modules/services/pairs"
}

module "ami" {
  source = "../modules/services/ami"
}

module "vpc" {
  source   = "../modules/services/vpc"
  VPC_cidr = var.VPC_cidr
}

module "asg" {
  source = "../modules/services/asg"
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source = "../modules/database/mysql"

  vpc_id     = module.vpc.vpc_id
  rds_asg_id = module.asg.rds_asg_id

  database_name     = var.database_name
  database_password = var.database_password
  database_user     = var.database_user
  instance_class    = var.instance_class
  AZ2               = var.AZ2
  AZ3               = var.AZ3
  subnet2_cidr      = var.subnet2_cidr
  subnet3_cidr      = var.subnet3_cidr
}

module "ec2" {
  source = "../modules/services/ec2"

  vpc_id       = module.vpc.vpc_id
  ec2_asg_id   = module.asg.ec2_asg_id
  ami_ubuntu   = module.ami.ami_ubuntu
  ami_linux    = module.ami.ami_linux
  akp_id       = module.pairs.akp_id
  rds_endpoint = module.rds.rds_endpoint
  tls_priv_key = module.pairs.tls_priv_key

  region           = var.region
  IsUbuntu         = var.IsUbuntu
  AZ1              = var.AZ1
  subnet1_cidr     = var.subnet1_cidr
  instance_type    = var.instance_type
  root_volume_size = var.root_volume_size
}