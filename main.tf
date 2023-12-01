module "roles" {
  source = "./modules/roles"

  for_each = var.assumers

  account_id   = each.key
  applications = each.value
}
