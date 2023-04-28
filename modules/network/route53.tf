data "aws_route53_zone" "hosted_zone" {
  name = var.zone_name
}

resource "aws_route53_record" "ecs_fargate_name" {
  allow_overwrite = true
  name            = var.ecs_fargate_name
  type            = "CNAME"
  ttl             = 300
  zone_id         = data.aws_route53_zone.hosted_zone.zone_id
  records         = [aws_alb.ecs_fargate.dns_name]
}

resource "aws_route53_record" "cert_verification_ecs_fargate" {
  name    = tolist(aws_acm_certificate.ecs_fargate.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.ecs_fargate.domain_validation_options)[0].resource_record_type
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  records = [tolist(aws_acm_certificate.ecs_fargate.domain_validation_options)[0].resource_record_value]
  ttl     = "60"
}

# resource "aws_route53_record" "cert_verification_ecs_fargate_second" {
#   name    = tolist(aws_acm_certificate.ecs_fargate.domain_validation_options)[1].resource_record_name
#   type    = tolist(aws_acm_certificate.ecs_fargate.domain_validation_options)[1].resource_record_type
#   zone_id = data.aws_route53_zone.hosted_zone.zone_id
#   records = [tolist(aws_acm_certificate.ecs_fargate.domain_validation_options)[1].resource_record_value]
#   ttl     = "60"
# }
