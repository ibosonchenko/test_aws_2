#output "secret_arn" {
#  value = one(aws_secretsmanager_secret.aws_secret[*].arn)
#}