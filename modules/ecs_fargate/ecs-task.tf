#    "image": "${data.aws_caller_identity.current.account_id}.dkr.ecr.eu-west-1.amazonaws.com/web-tools-recruiter:0",
#    "image": "${data.aws_caller_identity.current.account_id}.dkr.ecr.eu-west-1.amazonaws.com/web-courses-tools:0",
resource "aws_ecs_task_definition" "ecs_fargate" {
  family                   = "${var.cluster_name}-container"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = aws_iam_role.ecs_fargate_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_fargate_task_role.arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "smartservices-server-${var.environment}",
    "image": "nicadil/nginx-env:latest",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "ecs-fargate-${var.environment}",
        "awslogs-region": "eu-west-1",
        "awslogs-stream-prefix": "smartservices-server-${var.environment}"
      }
    },
    "essential": true,
    "portMappings": [{
      "protocol": "tcp",
      "containerPort": 80
    }],
    "environment": [
    {
      "name": "TZ",
      "value": "Europe/London"
    },
    {
      "name": "ENV",
      "value": "${var.environment}"
    },
    {
      "name": "NGINX_PORT",
      "value": "80"
    }
    ]
  },
   {
    "name": "smartservices-worker-${var.environment}",
    "image": "nicadil/nginx-env:latest",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "ecs-fargate-${var.environment}",
        "awslogs-region": "eu-west-1",
        "awslogs-stream-prefix": "smartservices-worker-${var.environment}"
      }
    },
    "essential": true,
    "portMappings": [{
      "protocol": "tcp",
      "containerPort": 81
    }],
    "environment": [
    {
      "name": "TZ",
      "value": "Europe/London"
    },
    {
      "name": "ENV",
      "value": "${var.environment}"
    },
    {
      "name": "NGINX_PORT",
      "value": "81"
    }
    ]
  } 
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
    #cpu_architecture        = "ARM64"    
  }

  lifecycle {
    ignore_changes = all  
  }
}