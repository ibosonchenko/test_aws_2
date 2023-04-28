# task to access it's own secret
data "aws_iam_policy_document" "ecs_fargate_task_iam_policy_secrets" {

  version = "2012-10-17"

  statement {
    sid    = "AllowToReadSecrets"
    effect = "Allow"
    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:ListSecretVersionIds"
    ]

    #resources = flatten([for secrets in locals.secrets: secrets])
    resources = ["*"]
  }
}