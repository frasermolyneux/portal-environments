resource "azurerm_app_configuration_key" "config_keys" {
  for_each = { for each in local.config_keys : each.key => each }

  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = each.value.key_name
  label = each.value.label
  value = each.value.value
}

resource "azurerm_app_configuration_key" "config_secret_keys" {
  for_each = { for each in local.config_secret_keys : each.key => each }

  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = each.value.key_name
  label = each.value.label

  vault_key_reference = azurerm_key_vault_secret.config_secret[each.value.key].versionless_id
}

// Dynamic keys from resources created in this repository
// Repository Web API V1
resource "azurerm_app_configuration_key" "repository_webapi_audience_v1" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "${local.repository_webapi_namespace_v1}:AzureAd:Audience"
  label = var.environment
  value = format("api://%s/%s", data.azuread_client_config.current.tenant_id, local.app_registration_name)
}

resource "azurerm_app_configuration_key" "repository_webapi_client_id_v1" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.repository_webapi_namespace_v1}:AzureAd:ClientId"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.repository_webapi_app_client_id_v1.versionless_id
}

resource "azurerm_app_configuration_key" "repository_webapi_client_secret_v1" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.repository_webapi_namespace_v1}:AzureAd:ClientSecret"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.repository_webapi_app_password_v1.versionless_id
}

// Repository Web API V2
resource "azurerm_app_configuration_key" "repository_webapi_audience_v2" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "${local.repository_webapi_namespace_v2}:AzureAd:Audience"
  label = var.environment
  value = format("api://%s/%s", data.azuread_client_config.current.tenant_id, local.app_registration_name)
}

resource "azurerm_app_configuration_key" "repository_webapi_client_id_v2" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.repository_webapi_namespace_v2}:AzureAd:ClientId"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.repository_webapi_app_client_id_v2.versionless_id
}

resource "azurerm_app_configuration_key" "repository_webapi_client_secret_v2" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.repository_webapi_namespace_v2}:AzureAd:ClientSecret"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.repository_webapi_app_password_v2.versionless_id
}

// Servers Integration API
resource "azurerm_app_configuration_key" "servers_integration_audience" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "${local.servers_integration_namespace}:AzureAd:Audience"
  label = var.environment
  value = format("api://%s/%s", data.azuread_client_config.current.tenant_id, local.servers_integration_app_registration_name)
}

resource "azurerm_app_configuration_key" "servers_integration_client_id" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.servers_integration_namespace}:AzureAd:ClientId"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.servers_integration_app_client_id.versionless_id
}

resource "azurerm_app_configuration_key" "servers_integration_client_secret" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.servers_integration_namespace}:AzureAd:ClientSecret"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.servers_integration_app_client_secret.versionless_id
}

// Repository Integration Tests
resource "azurerm_app_configuration_key" "repository_integration_tests_client_id" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.repository_integration_tests_namespace}:AzureAd:ClientId"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.repository_integration_tests_app_client_id.versionless_id
}

resource "azurerm_app_configuration_key" "repository_integration_tests_client_secret" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${local.repository_integration_tests_namespace}:AzureAd:ClientSecret"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.repository_integration_tests_app_client_secret.versionless_id
}

// Content Safety configuration
resource "azurerm_app_configuration_key" "content_safety_endpoint" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "ContentSafety:Endpoint"
  label = var.environment
  value = azurerm_cognitive_account.content_safety.endpoint
}

resource "azurerm_app_configuration_key" "content_safety_bot_admin_id" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "ContentSafety:BotAdminId"
  label = var.environment
  value = "21145"
}

resource "azurerm_app_configuration_key" "content_safety_severity_threshold" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "ContentSafety:SeverityThreshold"
  label = var.environment
  value = "4"
}

resource "azurerm_app_configuration_key" "content_safety_new_player_window_days" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "ContentSafety:NewPlayerWindowDays"
  label = var.environment
  value = "7"
}

resource "azurerm_app_configuration_key" "content_safety_min_message_length" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "ContentSafety:MinMessageLength"
  label = var.environment
  value = "5"
}

resource "azurerm_app_configuration_key" "content_safety_moderate_chat_tag_name" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "ContentSafety:ModerateChatTagName"
  label = var.environment
  value = "moderate-chat"
}

resource "azurerm_app_configuration_feature" "chat_toxicity_detection" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  name        = "EventIngest.ChatToxicityDetection"
  label       = var.environment
  enabled     = true
  description = "Enable AI-powered chat toxicity detection in event ingest pipeline"
}

resource "azurerm_app_configuration_feature" "auto_dlq_replay" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  name        = "EventIngest.AutoDlqReplay"
  label       = var.environment
  enabled     = true
  description = "Enable automatic dead-letter queue replay in event ingest pipeline"
}

// Portal Web application configuration (non-secret values)
resource "azurerm_app_configuration_key" "portal_web_repository_base_url" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "RepositoryApi:BaseUrl"
  label = var.environment
  value = "${azurerm_api_management.apim.gateway_url}/repository"
}

resource "azurerm_app_configuration_key" "portal_web_repository_audience" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "RepositoryApi:ApplicationAudience"
  label = var.environment
  value = one(azuread_application.repository_api_application.identifier_uris)
}

resource "azurerm_app_configuration_key" "portal_web_servers_integration_base_url" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "ServersIntegrationApi:BaseUrl"
  label = var.environment
  value = "${azurerm_api_management.apim.gateway_url}/servers-integration"
}

resource "azurerm_app_configuration_key" "portal_web_servers_integration_audience" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "ServersIntegrationApi:ApplicationAudience"
  label = var.environment
  value = one(azuread_application.servers_integration_api_application.identifier_uris)
}

// Shared configuration keys (used by multiple portal-* applications)
resource "azurerm_app_configuration_key" "shared_forums_base_url" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "XtremeIdiots:Forums:BaseUrl"
  label = var.environment
  value = "https://www.xtremeidiots.com"
}

resource "azurerm_app_configuration_key" "shared_forums_api_key" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "XtremeIdiots:Forums:ApiKey"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.shared_forums_api_key.versionless_id
}

resource "azurerm_app_configuration_key" "shared_map_redirect_base_url" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "MapRedirect:BaseUrl"
  label = var.environment
  value = "https://redirect.xtremeidiots.net"
}

resource "azurerm_app_configuration_key" "shared_map_redirect_api_key" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "MapRedirect:ApiKey"
  label = var.environment

  vault_key_reference = azurerm_key_vault_secret.shared_map_redirect_api_key.versionless_id
}

resource "azurerm_app_configuration_key" "shared_ftp_certificate_thumbprint" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "XtremeIdiots:FtpCertificateThumbprint"
  label = var.environment
  value = "65173167144EA988088DA20915ABB83DB27645FA"
}

// Shared URL configuration keys
resource "azurerm_app_configuration_key" "shared_forums_topic_base_url" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "XtremeIdiots:Forums:TopicBaseUrl"
  label = var.environment
  value = "https://www.xtremeidiots.com/forums/topic/"
}

resource "azurerm_app_configuration_key" "shared_portal_base_url" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "XtremeIdiots:PortalBaseUrl"
  label = var.environment
  value = "https://portal.xtremeidiots.com"
}

resource "azurerm_app_configuration_key" "shared_proxycheck_base_url" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "ProxyCheck:BaseUrl"
  label = var.environment
  value = "https://proxycheck.io/v2/"
}

resource "azurerm_app_configuration_key" "shared_gametracker_banner_base_url" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "GameTracker:BannerBaseUrl"
  label = var.environment
  value = "https://cache.gametracker.com/server_info/"
}

resource "azurerm_app_configuration_key" "shared_gametracker_map_image_base_url" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "GameTracker:MapImageBaseUrl"
  label = var.environment
  value = "https://image.gametracker.com/images/maps/160x120/"
}

resource "azurerm_app_configuration_key" "shared_gametracker_server_info_base_url" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "GameTracker:ServerInfoBaseUrl"
  label = var.environment
  value = "https://www.gametracker.com/server_info/"
}

// GeoLocation API configuration (shared values)
resource "azurerm_app_configuration_key" "geo_location_base_url" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "GeoLocationApi:BaseUrl"
  label = var.environment
  value = var.geo_location_api.base_url
}

resource "azurerm_app_configuration_key" "geo_location_audience" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "GeoLocationApi:ApplicationAudience"
  label = var.environment
  value = var.geo_location_api.application_audience
}

// GeoLocation API key — per-consumer App Config KV references
// Each consuming app loads its own app-scoped prefix and trims it,
// so the key resolves to "GeoLocationApi:ApiKey" in the app's IConfiguration.
resource "azurerm_app_configuration_key" "geo_location_api_key" {
  for_each = var.geo_location_api.consumers

  configuration_store_id = azurerm_app_configuration.app_configuration.id

  type = "vault"

  key   = "${each.value.app_config_prefix}:GeoLocationApi:ApiKey"
  label = var.environment

  vault_key_reference = each.value.keyvault_secret_uri
}

// Google configuration (Maps API key, Analytics ID)
resource "azurerm_app_configuration_key" "shared_google_maps_api_key" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key                    = "Google:MapsApiKey"
  type                   = "vault"
  label                  = var.environment
  vault_key_reference    = azurerm_key_vault_secret.shared_google_maps_api_key.versionless_id
}

resource "azurerm_app_configuration_key" "shared_google_analytics_id" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "Google:AnalyticsId"
  label = var.environment
  value = "G-F10FZ2SV5E"
}

// Application Insights sampling configuration (per-app, loaded via each app's scoped prefix)
resource "azurerm_app_configuration_key" "appinsights_initial_sampling" {
  for_each = {
    "XtremeIdiots.Portal.Web"                         = "5"
    "XtremeIdiots.Portal.Repository.Api.V1"           = "5"
    "XtremeIdiots.Portal.Repository.Api.V2"           = "5"
    "XtremeIdiots.Portal.Integrations.Servers.Api.V1" = "5"
  }

  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "${each.key}:ApplicationInsights:InitialSamplingPercentage"
  label = var.environment
  value = each.value
}

resource "azurerm_app_configuration_key" "appinsights_min_sampling" {
  for_each = {
    "XtremeIdiots.Portal.Web"                         = "5"
    "XtremeIdiots.Portal.Repository.Api.V1"           = "5"
    "XtremeIdiots.Portal.Repository.Api.V2"           = "5"
    "XtremeIdiots.Portal.Integrations.Servers.Api.V1" = "5"
  }

  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "${each.key}:ApplicationInsights:MinSamplingPercentage"
  label = var.environment
  value = each.value
}

resource "azurerm_app_configuration_key" "appinsights_max_sampling" {
  for_each = {
    "XtremeIdiots.Portal.Web"                         = "60"
    "XtremeIdiots.Portal.Repository.Api.V1"           = "60"
    "XtremeIdiots.Portal.Repository.Api.V2"           = "60"
    "XtremeIdiots.Portal.Integrations.Servers.Api.V1" = "60"
  }

  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "${each.key}:ApplicationInsights:MaxSamplingPercentage"
  label = var.environment
  value = each.value
}

// SQL resilience configuration (shared across portal-repository V1 and V2)
resource "azurerm_app_configuration_key" "shared_sql_retry_count" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "SqlResilience:RetryCount"
  label = var.environment
  value = "3"
}

resource "azurerm_app_configuration_key" "shared_sql_retry_delay_seconds" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "SqlResilience:RetryDelaySeconds"
  label = var.environment
  value = "5"
}

resource "azurerm_app_configuration_key" "shared_sql_command_timeout_seconds" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "SqlResilience:CommandTimeoutSeconds"
  label = var.environment
  value = "180"
}

// Data retention configuration (per-app)
resource "azurerm_app_configuration_key" "data_retention_recent_players_days" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "XtremeIdiots.Portal.Repository.Api.V1:DataRetention:RecentPlayersDays"
  label = var.environment
  value = "7"
}

resource "azurerm_app_configuration_key" "data_retention_inactive_player_days" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "XtremeIdiots.Portal.Repository.Api.V1:DataRetention:InactivePlayerDays"
  label = var.environment
  value = "14"
}

// Forum ID configuration — shared business constants
resource "azurerm_app_configuration_key" "shared_forums_default_admin_user_id" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "XtremeIdiots:Forums:DefaultAdminUserId"
  label = var.environment
  value = "21145"
}

resource "azurerm_app_configuration_key" "shared_forums_default_temp_ban_days" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "XtremeIdiots:Forums:DefaultTempBanDays"
  label = var.environment
  value = "7"
}

resource "azurerm_app_configuration_key" "shared_forums_default_forum_id" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "XtremeIdiots:Forums:DefaultForumId"
  label = var.environment
  value = "28"
}

// Forum IDs for admin logs (observations, kicks, warnings) per game type
resource "azurerm_app_configuration_key" "forums_admin_logs" {
  for_each = {
    CallOfDuty2 = "58"
    CallOfDuty4 = "59"
    CallOfDuty5 = "60"
    Insurgency  = "264"
    Minecraft   = "265"
    Rust        = "256"
    Arma        = "252"
  }

  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "XtremeIdiots:Forums:AdminLogs:${each.key}"
  label = var.environment
  value = each.value
}

// Forum IDs for bans (temp bans, permanent bans) per game type
resource "azurerm_app_configuration_key" "forums_bans" {
  for_each = {
    CallOfDuty2 = "68"
    CallOfDuty4 = "69"
    CallOfDuty5 = "70"
    Insurgency  = "169"
    Minecraft   = "144"
    Rust        = "260"
    Arma        = "259"
  }

  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "XtremeIdiots:Forums:Bans:${each.key}"
  label = var.environment
  value = each.value
}

// Sentinel key for dynamic configuration refresh
// Update the value (to any new value) after making configuration changes
// to trigger all portal-* apps to reload their configuration.
resource "azurerm_app_configuration_key" "sentinel" {
  configuration_store_id = azurerm_app_configuration.app_configuration.id

  key   = "Sentinel"
  label = var.environment
  value = timestamp()
}
