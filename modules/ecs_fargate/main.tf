resource "aws_ecs_cluster" "ecs_fargate" {
  name = var.cluster_name
}

resource "aws_ecs_cluster_capacity_providers" "ecs_fargate" {
  cluster_name = aws_ecs_cluster.ecs_fargate.name

  capacity_providers = ["FARGATE_SPOT", "FARGATE"]

  default_capacity_provider_strategy {
      capacity_provider = "FARGATE_SPOT"
      weight            = 1
  }
    
  default_capacity_provider_strategy {
      capacity_provider = "FARGATE"
      base              = 1
      weight            = 0
  }
}