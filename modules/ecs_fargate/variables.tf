# #--------------------------------------
# # Global
# #--------------------------------------

variable "environment" {
  type        = string
  default     = "dev"
  description = "(Required) name of environemnt which this cluster is in"
}

# variable "region" {
#   type        = string
#   default     = ""
#   description = "(Required) region for the deployment"
# }

# variable "zone_name" {
#   type        = string
#   default     = "trainsmart.com"
#   description = "the DNS zone name where we will create dns entry for the loadbalancer."
# }

# variable "zone_id" {
#   type        = string
#   default     = "Z32O12XQLNTSW2"
#   description = "the DNS zone id where we will create dns entry for the loadbalancer."
# }

# #--------------------------------------
# # ECS
# #--------------------------------------

variable "cluster_name" {
  type        = string
  default     = ""
  description = "(Required) the name of the ecs cluster"
}

variable  "aws_security_group_ecs_fargate_alb_id" {

}
variable "aws_alb_target_group_ecs_fargate_service_server_arn" {

}
# variable "aws_alb_target_group_ecs_fargate_service_worker_arn" {
  
# }
variable "private_subnet_ids" {
  
}
variable "public_subnet_ids" {
  
}
# variable "container_label" {
#   type        = string
#   default     = "v1"
#   description = "the label of the container to run"
# }

# variable "container_port" {
#   type        = string
#   default     = "80"
#   description = "the port our service is running on on the container"
# }

# variable "host_port" {
#   type        = string
#   default     = "80"
#   description = "the port to expose on the host"
# }

# variable "secret_name" {
#   type        = string
#   default     = null
#   description = "name of the secret"
# }

# variable "secret_description" {
#   type        = string
#   default     = null
#   description = "description of the secret"
# }

# variable "secret_recovery_window_in_days" {
#   type        = number
#   default     = 7
#   description = "Number of days that AWS Secrets Manager waits before it can delete the secret"
# }

# variable "secret_tags" {
#   type        = map(string)
#   default     = {}
#   description = "A map of tags to assign to AWS resources"
# }

# #--------------------------------------
# # VPC 
# #--------------------------------------

# variable "vpc_name" {
#   type        = string
#   default     = "ecs"
#   description = "name of the VPC"
# }
# variable "vpc_id" {
#   type        = string
#   default     = null
#   description = "The ID of the cluster VPC."
# }

# variable "public_access_cidrs" {
#   type        = list(string)
#   default     = []
#   description = <<EOT
#     (Required) List of CIDR blocks. Indicates which CIDR blocks can access
#     the Amazon ECS tasks
#   EOT
# }
# variable "private_access_cidrs" {
#   type        = list(string)
#   default     = []
#   description = <<EOT
#     (Required) List of CIDR blocks. Indicates which CIDR blocks can access
#     the Amazon ECS tasks
#   EOT
# }

# variable "private_access_security_groups" {
#   type        = list(string)
#   default     = []
#   description = <<EOT
#     (Required) List of Security Groups. Indicates which Security Groups can access
#     the Amazon ECS tasks
#   EOT
# }

# variable "private_subnet_ids" {
#   type        = list(string)
#   default     = []
#   description = <<EOT
#     (Required) List of subnet IDs. Must be in at least two different availability zones.
#   EOT
# }

# #--------------------------------------
# # Security Groups
# #--------------------------------------

# variable "additional_security_group_ids" {
#   type        = list(string)
#   default     = []
#   description = <<EOT
#     (Optional) List of extra security groups to run tasks as.
#   EOT
# }

# variable "secret_arns" {
#   type        = any
#   description = <<EOT
#     (Required) Map of secrets
#   EOT
# }

# variable "certificate_arn" {
#   type        = string
#   default     = null
#   description = "The ARN of the redis cluster used."
# }

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