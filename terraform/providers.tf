terraform {
  required_version = ">= 1.14.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.69.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 7.26"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.8.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {
    resource_group {
      # Resource group is only used by workload, App Insights creates artifacts that need to be deleted
      prevent_deletion_if_contains_resources = false
    }
  }

  storage_use_azuread = true
}

provider "azuread" {}

provider "google" {
  project = var.gcp_project_id
}

provider "random" {}
