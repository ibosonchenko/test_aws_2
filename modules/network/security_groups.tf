#----------------------------------
# Security grops for ALB
#----------------------------------

resource "aws_security_group" "ecs_fargate_alb" {
  name   = "ecs-fargate-alb-${var.environment}"
  description = "Allow access to ${var.environment} ALB"
  vpc_id = aws_vpc.vpc.id
 
  ingress {
   protocol         = "tcp"
   from_port        = "443"
   to_port          = "443"
   cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
   protocol         = "tcp"
   from_port        = "80"
   to_port          = "81"
   cidr_blocks      = ["0.0.0.0/0"]
  }  
 
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
  }
}

#----------------------------------
# Security grops for tasks
#----------------------------------

resource "aws_security_group" "ecs_fargate_tasks" {
  name   = "ecs-fargate-tasks-${var.environment}"
  description = "Allow access to ${var.environment} for tasks"
  
  vpc_id = aws_vpc.vpc.id
 
  ingress {
   protocol         = "tcp"
   from_port        = 80
   to_port          = 81
   cidr_blocks      = var.public_subnet_cidrs
  }

  ingress {
   protocol         = "tcp"
   from_port        = 80
   to_port          = 81
   security_groups  = [aws_security_group.ecs_fargate_alb.id]
  }
 
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
  }
}

# #----------------------------------
# # To do - need to describe rules
# #----------------------------------

# resource "aws_security_group" "ecs_fargate_alb_client" {
#   name   = "ecs-fargate-alb-client-${var.environment}"
#   description = "Allow access to ${var.environment} for client"
#   vpc_id = aws_vpc.vpc.id
#     ingress {
#         cidr_blocks = ["0.0.0.0/0"] 
#         from_port   = 80
#         to_port     = 80
#         protocol    = "tcp"
#     } 
#     ingress {
#         cidr_blocks = ["0.0.0.0/0"] 
#         from_port   = 443
#         to_port     = 443
#         protocol    = "tcp"
#     }     
    
#     # allow egress on all ports
#     egress {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }  
# }

# #----------------------------------
# # To do - need to clarified rules
# #----------------------------------

# resource "aws_security_group" "vpc" {
#     vpc_id = aws_vpc.vpc.id
#     name   = "vpc-${var.environment}"
#     description = "Allow access to ${var.environment} over SSH"
    
#     # allow ingress on port 22
#     ingress {
#         cidr_blocks = ["10.0.0.0/16"] 
#         from_port   = 22
#         to_port     = 22
#         protocol    = "tcp"
#     } 
    
#     # allow egress on all ports
#     egress {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     tags = {
#         Environment = var.environment
#   }
# }

# #----------------------------------
# # To do - need to describe rules
# #----------------------------------

# resource "aws_security_group" "private_access_security_groups" {
#   name   = "ecs-fargate-alb-private_access_security_groups-${var.environment}"
#   description = "Allow access to ${var.environment} for private access security groups"
#   vpc_id = aws_vpc.vpc.id
#     ingress {
#         cidr_blocks = ["10.0.0.0/16"] 
#         from_port   = 22
#         to_port     = 22
#         protocol    = "tcp"
#     } 
    
#     # allow egress on all ports
#     egress {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }  
# }
