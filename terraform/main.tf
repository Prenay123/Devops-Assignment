module "vpc" {

  source = "./modules/vpc"

  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone

}

module "keypair" {

  source = "./modules/keypair"

  key_name        = var.key_name
  public_key_path = var.public_key_path

}

module "security-group" {

  source = "./modules/security-group"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id

}

module "ec2" {

  source = "./modules/ec2"

  project_name      = var.project_name
  instance_type     = var.instance_type
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security-group.security_group_id
  key_name          = module.keypair.key_name
  user_data         = file("${path.module}/userdata/install-docker.sh")

}