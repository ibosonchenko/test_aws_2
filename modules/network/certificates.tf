resource "aws_acm_certificate" "ecs_fargate" {
  domain_name = "${var.ecs_fargate_name}.${var.zone_name}"
 # subject_alternative_names = ["*.${var.zone_name}"]
  validation_method = "DNS"
  tags = {
    Environment = var.environment
  }

 lifecycle {
   create_before_destroy = true
 }
}




