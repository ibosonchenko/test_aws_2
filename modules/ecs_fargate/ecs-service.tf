resource "aws_ecs_service" "ecs_fargate" {
  name                               = "${var.cluster_name}-fargate"
  cluster                            = aws_ecs_cluster.ecs_fargate.id
  task_definition                    = "${var.cluster_name}-container"
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 900
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"
  enable_execute_command             = true 
 
 network_configuration {
    #security_groups  = [aws_security_group.ecs_fargate_alb.id]
    security_groups  = [var.aws_security_group_ecs_fargate_alb_id]
    #subnets          = var.private_subnet_ids
    subnets          = var.private_subnet_ids    
    assign_public_ip = true
 }

# capacity_provider_strategy {
#    capacity_provider = "FARGATE_SPOT"
#    base              = var.spot_base
#    weight            = var.spot_weight
# }
    
# capacity_provider_strategy {
#    capacity_provider = "FARGATE"
#    base              = var.ondemand_base
#    weight            = var.ondemand_weight
#}
 
 ## need to hardcode loadbalancers until new loadbalancer attachment is available
 ## https://github.com/hashicorp/terraform-provider-aws/issues/23838

 load_balancer {
    target_group_arn = var.aws_alb_target_group_ecs_fargate_service_server_arn
    #target_group_arn = aws_alb_target_group.ecs_fargate_service_server["smartservices-server-${var.environment}"].arn
    container_name   = "smartservices-server-${var.environment}"
#    container_name   = "smartservices-server-dev"    
    container_port   = 80
 }

#    load_balancer {
#      target_group_arn = var.aws_alb_target_group_ecs_fargate_service_worker_arn
#      #target_group_arn = aws_alb_target_group.ecs_fargate_service_worker["smartservices-worker-${var.environment}"].arn
#      container_name   = "smartservices-worker-${var.environment}"
#      container_port   = 81
#   }
 
# lifecycle {
#    ignore_changes = [task_definition,launch_type]
 #}
  depends_on = [
    aws_ecs_task_definition.ecs_fargate
  ]  
}