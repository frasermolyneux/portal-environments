variable "environment" {
  default = "dev"
}

variable "workload_name" {
  description = "Name of the workload as defined in platform-workloads state"
  type        = string
  default     = "portal-environments"
}

variable "location" {
  default = "uksouth"
}

variable "subscription_id" {}

variable "platform_workloads_state" {
  description = "Backend config for platform-workloads remote state (used to read workload resource groups/backends)"
  type = object({
    resource_group_name  = string
    storage_account_name = string
    container_name       = string
    key                  = string
    subscription_id      = string
    tenant_id            = string
  })
}

variable "sql_admin_aad_group_members" {
  type    = list(string)
  default = []
}

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
    namespaces        = optional(list(string), [])
    tags              = optional(map(string), {})
    app_config_reader = optional(bool, true)
  }))
  default = {}
}
