resource "aws_alb" "ecs_fargate" {
  name               = var.cluster_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_fargate_alb.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]
  enable_deletion_protection = false  

  # to do - check if the following options are needed
  # desync_mitigation_mode = "defensive"
  # enable_http2           = true
  # idle_timeout           = 60
  # ip_address_type        = "ipv4"

  depends_on = [
    aws_acm_certificate.ecs_fargate
  ]  
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.ecs_fargate.id
    default_action {
    order = 1
    redirect {
      host        = "#{host}"
      path        = "/#{path}"
      port        = "443"
      protocol    = "HTTPS"
      query       = "#{query}"
      status_code = "HTTP_301"
    }

    type = "redirect"
  }

  port              = 80
  protocol          = "HTTP"

  tags = {
    env = "${var.environment}"
  }
}
 
resource "aws_alb_listener" "https" {
  certificate_arn = aws_acm_certificate.ecs_fargate.arn
  default_action {
    order            = 1
    target_group_arn = aws_alb_target_group.ecs_fargate_service_server.arn
    type             = "forward"
  }

  load_balancer_arn = aws_alb.ecs_fargate.id
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  tags = {
    env = "${var.environment}"
  }

}

resource "aws_alb_target_group" "ecs_fargate_service_server" {

  name        = "smartservices-server-${var.environment}"
  port        = 80
  protocol    = "HTTP"
  protocol_version     = "HTTP1"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
 
  health_check {
   healthy_threshold   = "2"
   interval            = "300"
   protocol            = "HTTP"
   matcher             = "200-399"
   timeout             = "5"
   path                = "/"
   unhealthy_threshold = "10"
  }
  # to do - check if the following options are needed  
    stickiness {
      cookie_duration = 86400
      type            = "lb_cookie"
    }   
  tags = {
    env = "${var.environment}"
  }

}

# resource "aws_alb_target_group" "ecs_fargate_service_worker" {

#   name        = "smartservices-worker"
#   port        = 81
#   protocol    = "HTTP"
#   vpc_id      = aws_vpc.vpc.id
#   target_type = "ip"
 
#   health_check {
#    healthy_threshold   = "2"
#    interval            = "300"
#    protocol            = "HTTP"
#    matcher             = "200-399"
#    timeout             = "5"
#    path                = "/"
#    unhealthy_threshold = "10"
#   }
#   # to do - check if the following options are needed  
#     stickiness {
#       cookie_duration = 86400
#       type            = "lb_cookie"
#     }  
# }

# resource "aws_alb_listener_rule" "ecs_fargate_service_server_https" {

#   listener_arn = aws_alb_listener.https.arn

#   action {
#     type             = "forward"
#     target_group_arn = aws_alb_target_group.ecs_fargate_service_server.arn
#   }

#   condition {
#     path_pattern {
#       values = ["/"]
#     }
#   }
# }

