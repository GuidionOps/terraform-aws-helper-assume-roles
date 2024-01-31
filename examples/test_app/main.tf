module "assumable_services" {
  source = "../../"

  assumers = {
    "001903534230" = {
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

module "assumable_services_with_policies" {
  source = "../../"

  assumers_with_policies = {
    "001903534230" = {
      "app-x" = {
        name = "some-table"
        policy = {
          Statement = [
            {
              Action = [
                "ecs:foo",
              ]
              Effect = "Allow"
              Resource = [
                "arn:aws:ecs:eu-central-1:656126335349:table/something"
              ]
            },
          ]
          Version = "2012-10-17"
        }
      }
    }
  }
}

output "assumable_role_arns_with_policies" {
  value = module.assumable_services_with_policies.account_applications_p
}
