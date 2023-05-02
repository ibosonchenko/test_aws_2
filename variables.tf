variable "environment" {
  type        = string
  description = "(Required) name of environemnt which this cluster is in"
}

variable "region" {
  type        = string
  description = "(Required) region for the deployment"
}

variable "zone_name" {
  type        = string
  description = "Hosted zone name in Route53, like as dev.trainsmart.com, prod.trainsmart.com"
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS cluster record name in Route53"
}

#--------------------------------------
# Capacity Providers
#--------------------------------------

variable "spot_base" {
  type        = number
  default     = null
  description = "The number of spot instances to have as minimum."
}

variable "spot_weight" {
  type        = number
  default     = null
  description = "The number of spot tasks to have over base as a ratio against on demand tasks."
}

variable "ondemand_base" {
  type        = number
  default     = null
  description = "The number of on demand tasks to have as minimum."
}

variable "ondemand_weight" {
  type        = number
  default     = null
  description = "The number of on demand tasks to have over base as a ratio against spot tasks."
}
