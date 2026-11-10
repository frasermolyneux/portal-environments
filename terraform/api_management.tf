resource "azurerm_api_management" "apim" {
  name                = local.api_management_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  publisher_name  = "XtremeIdiots"
  publisher_email = "admin@xtremeidiots.com"

  sku_name = "Consumption_0"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.managed["api_management"].id]
  }

  tags = var.tags
}

locals {
  apim_diagnostic_sampling_percentage = {
    dev = 2
    prd = 2
  }
}

data "azurerm_application_insights" "portal_core" {
  name                = "ai-portal-core-${var.environment}-${var.location}"
  resource_group_name = "rg-portal-core-${var.environment}-${var.location}"
}

resource "azurerm_api_management_logger" "application_insights" {
  name                = "applicationinsights"
  resource_group_name = azurerm_api_management.apim.resource_group_name
  api_management_name = azurerm_api_management.apim.name

  application_insights {
    instrumentation_key = data.azurerm_application_insights.portal_core.instrumentation_key
  }
}

resource "azurerm_api_management_diagnostic" "application_insights" {
  identifier               = "applicationinsights"
  resource_group_name      = azurerm_api_management.apim.resource_group_name
  api_management_name      = azurerm_api_management.apim.name
  api_management_logger_id = azurerm_api_management_logger.application_insights.id

  sampling_percentage = lookup(local.apim_diagnostic_sampling_percentage, var.environment, 2)
  always_log_errors   = true
  log_client_ip       = false
  verbosity           = "error"

  backend_request {
    body_bytes     = 0
    headers_to_log = []
  }

  backend_response {
    body_bytes     = 0
    headers_to_log = []
  }

  frontend_request {
    body_bytes     = 0
    headers_to_log = []
  }

  frontend_response {
    body_bytes     = 0
    headers_to_log = []
  }
}
