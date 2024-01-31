There are two ways to call this module, because I didn't want to break the less detailed way, which I still find useful:

1. Give a value to `var.assumers` with a simple map of objects consisting of the accounts => services to give access to. In this mode, the permissions are predetermined, and must be hardcoded into this module
1. Give a value to `var.assumers_with_policies` with a map of objects consisting of the accounts => applications => policies, which allows you to specify policies to attach to the IAM roles this module creates
