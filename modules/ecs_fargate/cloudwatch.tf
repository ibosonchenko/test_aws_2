resource "aws_cloudwatch_log_group" "log-group" {
  name = "ecs-fargate-${var.environment}"
  retention_in_days = 30
  tags = {
    Environment = "${var.environment}"
  }
}
