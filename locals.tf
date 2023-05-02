locals {

  project_name       = "app-ecs"
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]

  # ------ VPC ------
  vpc_name                      = "${local.project_name}-${var.environment}"
  vpc_cidr_block                = "10.0.0.0/16"
  public_subnet_cidrs           = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs          = ["10.0.3.0/24", "10.0.4.0/24"]
  database_subnet_cidrs         = ["10.0.5.0/24", "10.0.6.0/24"]
  private_subnet_allowed_cidrs  = "10.0.0.0/16"
  database_subnet_allowed_cidrs = "10.0.0.0/16"

  # number_of_nat_gateways (0 if not need)
  #number_of_nat_gateways = 1
  
  # ------ Route53 ------
  #zone_name = "ecs.dev.trainsmart.com"

  # ------ ECS ------
  cluster_name = "${local.project_name}-${var.environment}"

}
