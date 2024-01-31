resource "aws_iam_role" "these" {
  for_each = var.applications

  name = "${var.account_id}-${each.key}-assumable-p"
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
    for_each = var.applications

    content {
      name   = inline_policy.value.name
      policy = jsonencode(inline_policy.value.policy)
    }
  }
}
