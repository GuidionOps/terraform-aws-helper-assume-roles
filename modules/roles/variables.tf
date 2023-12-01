variable "account_id" {
  description = "The AWS account that will be doing the assuming"
  type        = string
}

variable "applications" {
  description = "Map of applications (in var.account_id) to services to create assume roles for"

  type = map(object(
    {
      dynamodb = optional(list(string), [])
      s3       = optional(list(string), [])
    }
  ))
}

variable "role_path" {
  description = "Optional override of path that role will be created in"
  type        = string
  default     = "external-aws-accounts"
}
