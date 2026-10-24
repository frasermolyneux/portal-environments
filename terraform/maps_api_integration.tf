locals {
  maps_api_identity = data.terraform_remote_state.platform_workloads.outputs.maps_service_identity

  maps_api_consumers = {
    sync = {
      namespace = local.sync_app_namespace
      roles     = toset(["Maps.Read"])
    }
    servers_integration = {
      namespace = local.servers_integration_namespace
      roles     = toset(["Maps.Read"])
    }
  }

  maps_api_role_assignments = {
    for assignment in flatten([
      for consumer, settings in local.maps_api_consumers : [
        for role in settings.roles : {
          key      = "${consumer}/${role}"
          consumer = consumer
          role     = role
        }
      ]
    ]) : assignment.key => assignment
  }
}

resource "azuread_app_role_assignment" "maps_api" {
  for_each = local.maps_api_role_assignments

  app_role_id         = local.maps_api_identity.role_ids[each.value.role]
  principal_object_id = azurerm_user_assigned_identity.managed[each.value.consumer].principal_id
  resource_object_id  = local.maps_api_identity.service_principal_id
}

resource "azurerm_app_configuration_key" "maps_api_base_url" {
  for_each = local.maps_api_consumers

  configuration_store_id = azurerm_app_configuration.app_configuration.id
  key                    = "${each.value.namespace}:RedirectApi:BaseUrl"
  label                  = var.environment
  value                  = "https://maps.xtremeidiots.com"
}

resource "azurerm_app_configuration_key" "maps_api_application_audience" {
  for_each = local.maps_api_consumers

  configuration_store_id = azurerm_app_configuration.app_configuration.id
  key                    = "${each.value.namespace}:RedirectApi:ApplicationAudience"
  label                  = var.environment
  value                  = local.maps_api_identity.identifier_uri
}
