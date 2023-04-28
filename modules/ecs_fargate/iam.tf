resource "aws_iam_role" "ecs_fargate_task_role" {
  name = "${var.cluster_name}-task-role"
 
  assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
        "Statement": [
            {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ecs-tasks.amazonaws.com"
                },
            "Effect": "Allow",
            "Sid": "assume"
            }
        ]
    }
EOF
}

resource "aws_iam_role" "ecs_fargate_task_execution_role" {
  name = "${var.cluster_name}-task-execution-role"
 
  assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
        "Statement": [
            {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ecs-tasks.amazonaws.com"
                },
            "Effect": "Allow",
            "Sid": ""
            }
        ]
    }
EOF
}

resource "aws_iam_policy" "ecr" {
  name        = "${var.cluster_name}-task-execution-policy-ecr"
  description = "Policy which allows access to ECR"
  policy      = data.aws_iam_policy_document.ecr.json
}

data "aws_iam_policy_document" "ecr" {
  statement {
    sid = "EcrAccess"
    actions = [
      "ecr:PutLifecyclePolicy",
      "ecr:PutImageTagMutability",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:CreateRepository",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken",
      "ecr:ListTagsForResource",
      "ecr:UploadLayerPart",
      "ecr:BatchDeleteImage",
      "ecr:DeleteLifecyclePolicy",
      "ecr:DeleteRepository",
      "ecr:PutImage",
      "ecr:UntagResource",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeImages",
      "ecr:TagResource",
      "ecr:DescribeRepositories",
      "ecr:StartLifecyclePolicyPreview",
      "ecr:InitiateLayerUpload",
      "ecr:DeleteRepositoryPolicy",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetRepositoryPolicy",
      "ecr:GetLifecyclePolicy",
      "ecr:StartImageScan",
      "ecr:DescribeImageScanFindings",
    ]
    resources = ["*",]
  }
}
 
resource "aws_iam_role_policy_attachment" "ecs_task_role_policy_attachment" {
  role       = aws_iam_role.ecs_fargate_task_execution_role.name
  policy_arn = aws_iam_policy.ecr.arn
}
 
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_fargate_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_iam_policy" "logging" {
  name        = "${var.cluster_name}-task-execution-policy-logging"
  description = "Policy that allows access to logging"
  policy      = data.aws_iam_policy_document.logging.json
}

data "aws_iam_policy_document" "logging" {
  statement {
    sid = "logging"
    actions = [
      "logs:Create*",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:eu-west-1:${data.aws_caller_identity.current.account_id}:log-group:awslogs-ecs-fargate:*",
      "arn:aws:logs:eu-west-1:${data.aws_caller_identity.current.account_id}:log-group:awslogs-ecs-fargate-datadog:*",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_logging_policy_attachment" {
  role       = aws_iam_role.ecs_fargate_task_role.id
  policy_arn = aws_iam_policy.logging.arn
}

resource "aws_iam_policy" "ecs_fargate_task_iam_policy_secrets" {
  name   = format("%s-secrets", var.cluster_name)
  policy = data.aws_iam_policy_document.ecs_fargate_task_iam_policy_secrets.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_policy_secrets_attachment" {
  role       = aws_iam_role.ecs_fargate_task_role.name
  policy_arn = aws_iam_policy.ecs_fargate_task_iam_policy_secrets.arn
}