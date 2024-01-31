output "assumable_role_arns" {
  value = { for this_account, these_values in aws_iam_role.these : this_account => these_values.arn }
}
