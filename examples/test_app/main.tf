module "assumable_services" {
  source = "../../"

  assumers = {
    "213742530112" = {
      "app-x" = {
        "dynamodb" = ["some-table"],
        "s3"       = ["foobar-bucket"]
      }
    }
  }
}

output "assumable_role_arns" {
  value = module.assumable_services.account_applications
}
