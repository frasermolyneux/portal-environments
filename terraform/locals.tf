locals {
  workload_resource_group = data.terraform_remote_state.platform_workloads.outputs.workload_resource_groups[var.workload_name][var.environment].resource_groups[lower(var.location)]
  resource_group_name     = local.workload_resource_group.name

  app_configuration_name = "appcs-portal-${var.environment}-${var.location}"
  sql_admin_group_name   = "sql-portal-admins-${var.environment}"

  repository_webapi_namespace_v1         = "XtremeIdiots.Portal.Repository.Api.V1"
  repository_webapi_namespace_v2         = "XtremeIdiots.Portal.Repository.Api.V2"
  repository_integration_tests_namespace = "XtremeIdiots.Portal.Repository.IntegrationTests"

  app_registration_name       = "portal-repository-${var.environment}-01"
  tests_app_registration_name = "portal-repository-integration-tests-${var.environment}"
}

locals {
  managed_identities = {
    for key, identity in var.managed_identities : key => {
      name              = format("id-portal-%s-%s", identity.name_suffix, var.environment)
      namespaces        = identity.namespaces
      tags              = merge(var.tags, identity.tags)
      app_config_reader = identity.app_config_reader
    }
  }

  managed_identity_namespace_pairs = flatten([
    for identity_key, identity in local.managed_identities : [
      for namespace in identity.namespaces : {
        identity_key = identity_key
        namespace    = namespace
      }
    ]
  ])

  json_files = [for config in var.app_configs : jsondecode(file("app_configs/${config}.json"))]

  configs = [for content in local.json_files : {
    label     = content.label,
    namespace = content.namespace,
    keys = [for key in lookup(content, "keys", []) : {
      key   = key.key,
      value = lookup(key, "value", "")
    }]
    secret_keys = [for key in lookup(content, "secret_keys", []) : {
      key        = key.key
      expiration = lookup(key, "expiration", null)
    }]
  }]

  config_keys = flatten([
    for config in local.configs : [
      for key in config.keys : {
        key       = format("%s|%s|%s", config.namespace, config.label, key.key)
        label     = config.label
        key_name  = format("%s:%s", config.namespace, key.key)
        namespace = config.namespace
        value     = key.value
      }
    ]
  ])

  config_secret_keys = flatten([
    for config in local.configs : [
      for key in config.secret_keys : {
        key        = format("%s|%s|%s", config.namespace, config.label, key.key)
        label      = config.label
        key_name   = format("%s:%s", config.namespace, key.key)
        namespace  = config.namespace
        expiration = key.expiration
      }
    ]
  ])
}
