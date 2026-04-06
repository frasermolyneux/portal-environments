environment = "prd"
location    = "uksouth"

subscription_id = "32444f38-32f4-409f-889c-8e8aa2b5b4d1"

platform_workloads_state = {
  resource_group_name  = "rg-tf-platform-workloads-prd-uksouth-01"
  storage_account_name = "sadz9ita659lj9xb3"
  container_name       = "tfstate"
  key                  = "terraform.tfstate"
  subscription_id      = "7760848c-794d-4a19-8cb2-52f71a21ac2b"
  tenant_id            = "e56a6947-bb9a-4a6e-846a-1f118d1c3a14"
}

sql_admin_aad_group_members = [
  "spn-portal-repository-production",
  "spn-portal-web-production"
]

app_configuration_sku = "developer"

app_configs = ["repository-webapi-v1-prd", "repository-webapi-v2-prd", "repository-integration-tests-prd", "servers-integration-webapi-v1-prd", "portal-web-prd"]

tags = {
  Environment = "prd",
  Workload    = "portal-environments",
  DeployedBy  = "GitHub-Terraform",
  Git         = "https://github.com/frasermolyneux/portal-environments"
}

managed_identities = {
  api_management = {
    namespaces = []
  }

  sql_server = {
    namespaces        = []
    app_config_reader = false
  }

  repository = {
    namespaces = [
      "XtremeIdiots.Portal.Repository.Api.V1",
      "XtremeIdiots.Portal.Repository.Api.V2"
    ]
  }

  servers_integration = {
    namespaces = [
      "XtremeIdiots.Portal.Integrations.Servers.Api.V1"
    ]
  }

  web = {
    namespaces = [
      "XtremeIdiots.Portal.Web"
    ]
  }

  sync = {
    namespaces = []
  }

  repository_func = {
    namespaces = []
  }

  server_agent = {
    namespaces = []
  }

  server_events = {
    namespaces = []
  }
}

geo_location_api = {
  base_url             = "https://apim-geo-location-prd-swedencentral-6f10eaac01a0.azure-api.net/geolocation"
  application_audience = "api://e56a6947-bb9a-4a6e-846a-1f118d1c3a14/geolocation-api-prd"
  consumers = {
    web = {
      app_config_prefix   = "XtremeIdiots.Portal.Web"
      keyvault_secret_uri = "https://kv-18ac60675297-swe.vault.azure.net/secrets/portal-web-prd-apim-subscription-key"
    }
    repository_func = {
      app_config_prefix   = "XtremeIdiots.Portal.Repository.App"
      keyvault_secret_uri = "https://kv-11624f0ecabd-swe.vault.azure.net/secrets/portal-repository-func-prd-apim-subscription-key"
    }
    server_events = {
      app_config_prefix   = "XtremeIdiots.Portal.Server.Events.Processor.App"
      keyvault_secret_uri = "https://kv-dc0945324e02-swe.vault.azure.net/secrets/portal-server-events-prd-apim-subscription-key"
    }
  }
}

gcp_project_id = "gcp-mx-io-portal-environments"

google_maps_allowed_referrers = [
  "https://portal.xtremeidiots.com/*"
]
