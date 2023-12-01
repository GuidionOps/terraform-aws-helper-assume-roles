output "account_applications" {
  value = { for this_account, these_values in module.roles : this_account => these_values.assumable_role_arns }
}
