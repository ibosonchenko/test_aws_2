locals {

  #project name
  project_name = "trainsamrt-v2"

  # list of availability zones  
  availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]

  # VPC name
  vpc_name = "${local.project_name}-${var.environment}"

  # the VPC CIDR address
  vpc_cidr_block = "10.0.0.0/16"

  # list of ordered CIDR's for public subnets
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]

  # list of ordered CIDR's for private subnets
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

  # list of ordered CIDR's for database subnets
  database_subnet_cidrs = ["10.0.5.0/24", "10.0.6.0/24"]

  # allowed CIDR's for private subnets
  private_subnet_allowed_cidrs = "10.0.0.0/16"

  # allowed CIDR's for database subnets
  database_subnet_allowed_cidrs = "10.0.0.0/16"

  # number_of_nat_gateways (0 if not need)
  number_of_nat_gateways = 1
  
  # ECS cluster name
  cluster_name = "${local.project_name}-${var.environment}"

}
