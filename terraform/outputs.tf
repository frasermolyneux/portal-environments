// Azure App Configuration (shared across workloads)
output "app_configuration" {
  description = "App Configuration endpoint and identifiers."
  value = {
    name                = azurerm_app_configuration.app_configuration.name
    id                  = azurerm_app_configuration.app_configuration.id
    endpoint            = azurerm_app_configuration.app_configuration.endpoint
    resource_group_name = azurerm_app_configuration.app_configuration.resource_group_name
    location            = azurerm_app_configuration.app_configuration.location
  }
}

// User Assigned Identities keyed by workload/environment
output "managed_identities" {
  description = "Managed identities with id, client_id, and principal_id keyed by identity name."
  value = {
    for key, identity in azurerm_user_assigned_identity.managed :
    key => {
      id           = identity.id
      client_id    = identity.client_id
      principal_id = identity.principal_id
    }
  }
}

output "api_management" {
  description = "API Management instance details for downstream consumers."
  value = {
    name                = azurerm_api_management.apim.name
    id                  = azurerm_api_management.apim.id
    resource_group_name = azurerm_api_management.apim.resource_group_name
    location            = azurerm_api_management.apim.location
    gateway_url         = azurerm_api_management.apim.gateway_url
  }
}

output "sql_admin_group" {
  description = "Details for the SQL administrator Azure AD group."
  value = {
    display_name = azuread_group.sql_admin_group.display_name
    object_id    = azuread_group.sql_admin_group.object_id
  }
}

output "sql_repository_readers_group" {
  description = "Details for the SQL repository readers Azure AD group."
  value = {
    display_name = azuread_group.sql_repository_readers_group.display_name
    object_id    = azuread_group.sql_repository_readers_group.object_id
  }
}

output "sql_repository_writers_group" {
  description = "Details for the SQL repository writers Azure AD group."
  value = {
    display_name = azuread_group.sql_repository_writers_group.display_name
    object_id    = azuread_group.sql_repository_writers_group.object_id
  }
}

output "repository_api" {
  description = "Repository API app registration and service principal metadata for downstream consumers."
  value = {
    application = {
      display_name           = azuread_application.repository_api_application.display_name
      object_id              = azuread_application.repository_api_application.id
      application_id         = azuread_application.repository_api_application.client_id
      primary_identifier_uri = one(azuread_application.repository_api_application.identifier_uris)
    }
    service_principal = {
      object_id = azuread_service_principal.repository_api_service_principal.id
    }
    api_management = {
      root_path = "repository"
      endpoint  = "${azurerm_api_management.apim.gateway_url}/repository"
    }
  }
}

output "event_ingest_api" {
  description = "Event ingest API app registration and service principal metadata for downstream consumers."
  value = {
    application = {
      display_name           = azuread_application.event_ingest_api_application.display_name
      object_id              = azuread_application.event_ingest_api_application.id
      application_id         = azuread_application.event_ingest_api_application.client_id
      primary_identifier_uri = one(azuread_application.event_ingest_api_application.identifier_uris)
    }
    service_principal = {
      object_id = azuread_service_principal.event_ingest_api_service_principal.id
    }
    api_management = {
      root_path = "event-ingest"
      endpoint  = "${azurerm_api_management.apim.gateway_url}/event-ingest"
    }
  }
}

output "servers_integration_api" {
  description = "Servers Integration API app registration and service principal metadata for downstream consumers."
  value = {
    application = {
      display_name           = azuread_application.servers_integration_api_application.display_name
      object_id              = azuread_application.servers_integration_api_application.id
      application_id         = azuread_application.servers_integration_api_application.client_id
      primary_identifier_uri = one(azuread_application.servers_integration_api_application.identifier_uris)
    }
    service_principal = {
      object_id = azuread_service_principal.servers_integration_api_service_principal.id
    }
    api_management = {
      root_path = "servers-integration"
      endpoint  = "${azurerm_api_management.apim.gateway_url}/servers-integration"
    }
  }
}
