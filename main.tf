data "aws_availability_zones" "available" {}

module "vpc" {
  source = "./modules/vpc"

  application             = var.application
  cidr                    = var.vpc_cidr_block
  region                  = var.region
  key_name                = var.key_name
  controller_subnet_zones = var.controller_subnet_zones
  controller_subnet_cidr  = var.controller_subnet_cidr
  public_subnet_zone      = var.public_subnet_zone
  public_subnet_cidr      = var.public_subnet_cidr
  worker_group_count      = var.worker_group_count
  worker_subnet_zones     = var.worker_subnet_zones
  worker_subnet_cidr      = var.worker_subnet_cidr
  manager_group_count     = var.manager_group_count
  manager_subnet_zones    = var.manager_subnet_zones
  manager_subnet_cidr     = var.manager_subnet_cidr
  nat_subnet_zones        = var.nat_subnet_zones
  nat_subnet_cidr         = var.nat_subnet_cidr
}

module "bastion" {
  source = "./modules/bastion"

  region          = var.region
  key_name        = var.key_name
  application     = var.application
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.public_subnet_id
  connection_user = var.connection_user
  private_key     = file("${var.key_name}.pem")
}

module "cicd" {
  source = "./modules/cicd"

  region          = var.region
  key_name        = var.key_name
  application     = var.application
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.public_subnet_id
  connection_user = var.connection_user
  private_key     = file("${var.key_name}.pem")
}

module "monitor" {
  source = "./modules/monitor"

  region          = var.region
  key_name        = var.key_name
  application     = var.application
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.public_subnet_id
  connection_user = var.connection_user
  private_key     = file("${var.key_name}.pem")
}


module "proxy" {
  source = "./modules/proxy"

  region          = var.region
  key_name        = var.key_name
  application     = var.application
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.public_subnet_id
  connection_user = var.connection_user
  private_key     = file("${var.key_name}.pem")
}

module "manager" {
  source = "./modules/nodes/manager"

  region             = var.region
  key_name           = var.key_name
  application        = var.application
  manager_count      = var.manager_count
  vpc_id             = module.vpc.vpc_id
  manager_subnet_ids = module.vpc.manager_subnet_ids

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 32
      encrypted   = true
    },
  ]

  gluster_volume_size = var.gluster_volume_size
}

module "worker" {
  source = "./modules/nodes/worker"

  region            = var.region
  key_name          = var.key_name
  application       = var.application
  worker_count      = var.worker_count
  vpc_id            = module.vpc.vpc_id
  worker_subnet_ids = module.vpc.worker_subnet_ids

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 32
      encrypted   = true
    },
  ]

  gluster_volume_size = var.gluster_volume_size
}
