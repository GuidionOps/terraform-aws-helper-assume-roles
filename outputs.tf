output "account_applications" {
  description = "Map of account numbers to role ARNs created"
  value       = { for this_account, these_values in module.roles : this_account => these_values.assumable_role_arns }
}

output "account_applications_p" {
  description = "Map of account numbers to role ARNs created for var.assumers_with_policies"
  value       = { for this_account, these_values in module.roles_with_policies : this_account => these_values.assumable_role_arns }
}
