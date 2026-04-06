environment = "dev"
location    = "swedencentral"

subscription_id = "6cad03c1-9e98-4160-8ebe-64dd30f1bbc7"

platform_workloads_state = {
  resource_group_name  = "rg-tf-platform-workloads-prd-uksouth-01"
  storage_account_name = "sadz9ita659lj9xb3"
  container_name       = "tfstate"
  key                  = "terraform.tfstate"
  subscription_id      = "7760848c-794d-4a19-8cb2-52f71a21ac2b"
  tenant_id            = "e56a6947-bb9a-4a6e-846a-1f118d1c3a14"
}

sql_admin_aad_group_members = [
  "spn-portal-repository-development",
  "spn-portal-web-development"
]

app_configuration_sku = "developer"

app_configs = ["repository-webapi-v1-dev", "repository-webapi-v2-dev", "repository-integration-tests-dev", "servers-integration-webapi-v1-dev", "portal-web-dev", "sync-app-dev"]

tags = {
  Environment = "dev",
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
    namespaces = [
      "XtremeIdiots.Portal.Sync.App"
    ]
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
      keyvault_secret_uri = "https://kv-03bc577ff535-swe.vault.azure.net/secrets/portal-web-dev-apim-subscription-key"
    }
    repository_func = {
      app_config_prefix   = "XtremeIdiots.Portal.Repository.App"
      keyvault_secret_uri = "https://kv-2c8ee2a142b1-swe.vault.azure.net/secrets/portal-repository-func-dev-apim-subscription-key"
    }
    server_events = {
      app_config_prefix   = "XtremeIdiots.Portal.Server.Events.Processor.App"
      keyvault_secret_uri = "https://kv-5c168d6b3996-swe.vault.azure.net/secrets/portal-server-events-dev-apim-subscription-key"
    }
  }
}

gcp_project_id = "gcp-mx-io-portal-environments"

google_maps_allowed_referrers = [
  "https://portal.dev.xtremeidiots.dev/*"
]
