data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_iam_role" "these" {
  for_each = var.applications

  name = "${var.account_id}-${each.key}-assumable"
  path = "/${var.role_path}/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = var.account_id
        }
      },
    ]
  })

  dynamic "inline_policy" {
    for_each = each.value.dynamodb

    content {
      name = inline_policy.value

      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "dynamodb:GetItem",
              "dynamodb:UpdateItem",
              "dynamodb:GetRecords",
              "dynamodb:GetShardIterator",
              "dynamodb:DescribeStream",
              "dynamodb:ListStreams"
            ]
            Resource = [
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:table/${inline_policy.value}",
              "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:table/${inline_policy.value}/*"
            ]
          },
        ]
      })
    }
  }

  dynamic "inline_policy" {
    for_each = each.value.s3

    content {
      name = inline_policy.value

      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "s3:*"
            ]
            Resource = [
              "arn:aws:s3:::${inline_policy.value}",
              "arn:aws:s3:::${inline_policy.value}/*",
            ]
          },
        ]
      })
    }
  }

  dynamic "inline_policy" {
    for_each = each.value.ecs

    content {
      name = inline_policy.value

      policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
              Effect = "Allow"
              Action = [
                  "ecs:RunTask",
                  "ecs:DescribeTasks"
              ]
              Resource = [
                  "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:task-definition/dbt-dev-task"
              ]
            },
            {
              Effect = "Allow"
              Action = [
                  "iam:PassRole"
              ]
              Resource = [
                  "arn:aws:iam::${data.aws_caller_identity.current.id}:role/dbt-guidion-dev-fargate-task-role-d3b329c"
                  # "arn:aws:iam::${data.aws_caller_identity.current.id}:role/dbt-guidion-dev-ecs-execution-role-a784f37"
              ]
            },
            {
              Effect = "Allow"
              Action = [
                "ecs:DescribeTasks"
              ]
              Resource = [ 
                "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:task/dbt-dev-cluster/*"
              ]
          },
        ]
      })
    }
  }
}