variable "environment" {
  default = "dev"
}

variable "location" {
  default = "uksouth"
}

variable "subscription_id" {}

variable "log_analytics_subscription_id" {}
variable "log_analytics_resource_group_name" {}
variable "log_analytics_workspace_name" {}

variable "app_configuration_sku" {
  default = "free"
}

variable "app_configs" {
  type = list(string)
}

variable "tags" {
  default = {}
}

variable "managed_identities" {
  description = "Map of managed identities to create along with namespace access and role preferences."
  type = map(object({
    name_suffix       = string
    namespaces        = optional(list(string), [])
    tags              = optional(map(string), {})
    app_config_reader = optional(bool, true)
  }))
  default = {}
}
