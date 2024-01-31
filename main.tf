module "roles" {
  source = "./modules/roles"

  for_each = var.assumers

  account_id   = each.key
  applications = each.value
}

module "roles_with_policies" {
  source = "./modules/roles_with_policies"

  for_each = var.assumers_with_policies

  account_id   = each.key
  applications = each.value
}
