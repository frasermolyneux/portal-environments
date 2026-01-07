locals {
  # Remote State References
  workload_resource_groups = {
    for location in [var.location] :
    location => data.terraform_remote_state.platform_workloads.outputs.workload_resource_groups[var.workload_name][var.environment].resource_groups[lower(location)]
  }

  workload_backend = try(
    data.terraform_remote_state.platform_workloads.outputs.workload_terraform_backends[var.workload_name][var.environment],
    null
  )

  workload_administrative_unit = try(
    data.terraform_remote_state.platform_workloads.outputs.workload_administrative_units[var.workload_name][var.environment],
    null
  )

  workload_resource_group = local.workload_resource_groups[var.location]

  # Local Resource Naming
  app_configuration_name            = "appcs-portal-${var.environment}-${var.location}-${random_id.environment_id.hex}"
  sql_admin_group_name              = "sg-sql-portal-core-admins-${var.environment}"
  sql_repository_readers_group_name = "sg-sql-portal-repository-readers-${var.environment}"
  sql_repository_writers_group_name = "sg-sql-portal-repository-writers-${var.environment}"

  key_vault_names = {
    for namespace, id in random_id.config_id : namespace => substr(format("kv-%s-%s", id.hex, var.location), 0, 24)
  }

  app_registration_name              = "portal-repository-${var.environment}-01"
  tests_app_registration_name        = "portal-repository-integration-tests-${var.environment}"
  event_ingest_app_registration_name = "portal-event-ingest-${var.environment}"

  # Static Naming
  repository_webapi_namespace_v1         = "XtremeIdiots.Portal.Repository.Api.V1"
  repository_webapi_namespace_v2         = "XtremeIdiots.Portal.Repository.Api.V2"
  repository_integration_tests_namespace = "XtremeIdiots.Portal.Repository.IntegrationTests"
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

locals {
  spec_storage_account_name = format("sa%s", random_id.spec_storage.hex)
  spec_storage_containers   = ["event-ingest", "servers-integration", "repository"]

  spec_publisher_principal_ids = {
    event_ingest        = data.terraform_remote_state.platform_workloads.outputs.workload_service_principals["portal-event-ingest"][var.environment].service_principal_object_id
    servers_integration = data.terraform_remote_state.platform_workloads.outputs.workload_service_principals["portal-servers-integration"][var.environment].service_principal_object_id
    repository          = data.terraform_remote_state.platform_workloads.outputs.workload_service_principals["portal-repository"][var.environment].service_principal_object_id
  }
}
