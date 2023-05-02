variable "environment" {
  type        = string
  description = "e.g. dev, stage, prod"
}

variable "region" {
  type        = string
  description = "e.g. eu-west-1"
}

variable "availability_zones" {
  type        = list(string)
  description = "list of availability zones"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "vpc_cidr_block" {
  type        = string  
  description = "VPC CIDR address e.g. 10.10.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "list of ordered CIDR's for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "list of ordered CIDR's for private subnets"
}

variable "database_subnet_cidrs" {
   type        = list(string)
   description = "list of ordered CIDR's for database subnets"     
 }

variable "private_subnet_allowed_cidrs" {
   type        = string
   description = "list of allowed CIDR's for private subnets"
}

variable "database_subnet_allowed_cidrs" {
   type        = string
   description = "list of allowed CIDR's for database subnets"
}

# variable "number_of_nat_gateways" {
#   type        = number
#   description = "typically 1"
# }

variable "zone_name" {
   type        = string
   description = "Hosted zone name in Route53"     
}
 
variable "ecs_cluster_name" {
   type        = string
   description = "ECS cluster record name in Route53"  
}

variable "cluster_name" {
  type        = string
  description = "the name of the ecs cluster"
}