variable "assumers" {
  description = "Map of map of objects: Account ID -> Application Name -> Services to give access to"

  type = map(
    map(object(
      {
        dynamodb = optional(list(string), [])
        s3       = optional(list(string), [])
      }
    ))
  )

  default = {}
}

variable "assumers_with_policies" {
  description = "Map of map of objects: Account ID -> Application Name -> Policy to give access to"

  type = map(
    map(object(
      {
        name   = string
        policy = any
      }
    ))
  )

  default = {}
}
