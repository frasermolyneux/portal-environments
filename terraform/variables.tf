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
