provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "iam" {
  source = "./modules/iam"
}

module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}

module "ecs" {
  source               = "./modules/ecs"
  vpc_id               = module.vpc.vpc_id
  private_subnets      = module.vpc.private_subnets
  ecs_task_exec_role_arn = module.iam.ecs_exec_role_arn
  target_group_arn     = module.alb.target_group_arn
  alb_security_group_id = module.alb.alb_security_group_id
}

module "nat_gateway" {
  source             = "./modules/nat-gateway"
  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.vpc.public_subnets[0] # Just 1 needed for NAT
  private_subnet_ids = module.vpc.private_subnets
}
