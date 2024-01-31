variable "account_id" {
  description = "The AWS account that will be doing the assuming"
  type        = string
}

variable "applications" {
  description = "Map of names to policies to create inline"

  type = map(object({
    name   = string
    policy = any
  }))
}

variable "role_path" {
  description = "Optional override of path that role will be created in"
  type        = string
  default     = "external-aws-accounts"
}
