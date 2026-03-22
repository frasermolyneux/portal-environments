resource "google_apikeys_key" "portal_maps" {
  name         = format("portal-maps-%s", var.environment)
  display_name = format("Portal Maps API Key - %s", var.environment)
  project      = var.gcp_project_id

  restrictions {
    api_targets {
      service = "maps-backend.googleapis.com"
    }

    browser_key_restrictions {
      allowed_referrers = var.google_maps_allowed_referrers
    }
  }
}
