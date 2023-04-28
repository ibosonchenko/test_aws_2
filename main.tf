module "network" {
  source = "./modules/network"

  environment      = var.environment
  region           = var.region
  zone_name        = var.zone_name
  ecs_fargate_name = var.ecs_fargate_name

  vpc_name                      = local.vpc_name
  vpc_cidr_block                = local.vpc_cidr_block
  availability_zones            = local.availability_zones
  public_subnet_cidrs           = local.public_subnet_cidrs
  private_subnet_cidrs          = local.private_subnet_cidrs
  database_subnet_cidrs         = local.database_subnet_cidrs
  private_subnet_allowed_cidrs  = local.private_subnet_allowed_cidrs
  database_subnet_allowed_cidrs = local.database_subnet_allowed_cidrs
  number_of_nat_gateways        = local.number_of_nat_gateways
  cluster_name                  = local.cluster_name
}

module "ecs_fargate" {
  source = "./modules/ecs_fargate"

  environment      = var.environment

  cluster_name                  = local.cluster_name
  aws_security_group_ecs_fargate_alb_id = module.network.aws_security_group_ecs_fargate_alb_id
  aws_alb_target_group_ecs_fargate_service_server_arn = module.network.aws_alb_target_group_ecs_fargate_service_server_arn
  #aws_alb_target_group_ecs_fargate_service_worker_arn = module.network.aws_alb_target_group_ecs_fargate_service_worker_arn
  private_subnet_ids = module.network.private_subnet_ids
  public_subnet_ids = module.network.public_subnet_ids
  spot_base = var.spot_base
  spot_weight = var.spot_weight
  ondemand_base = var.ondemand_base
  ondemand_weight = var.ondemand_weight
}