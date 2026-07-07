// CoD4x Plugin APIM access
//
// The CoD4x server plugin runs on the constrained CoD4x HTTP stack, which cannot
// send an Authorization: Bearer <JWT> header (fixed request-header buffers truncate
// large tokens). Instead the plugin authenticates to APIM with a short
// Ocp-Apim-Subscription-Key header. APIM's managed identity then forwards to
// Service Bus (event ingest) and the Repository API (ban reads) on the plugin's
// behalf, so no per-identity token is required on the plugin side.
//
// The product is scoped to only the CoD4x ingest API (least privilege). The
// product<->API membership link is created in the portal-server-events repository
// (which owns that API) using the product_id exported from this stack.

resource "azurerm_api_management_product" "cod4x_plugin" {
  product_id          = "cod4x-plugin"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_api_management.apim.resource_group_name

  display_name          = "CoD4x Plugin"
  description           = "Subscription-key access for the CoD4x server plugin (event ingest and ban reads)."
  subscription_required = true
  approval_required     = false
  published             = true
}

resource "azurerm_api_management_subscription" "cod4x_plugin" {
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_api_management.apim.resource_group_name
  product_id          = azurerm_api_management_product.cod4x_plugin.id

  display_name = "CoD4x Plugin"
  state        = "active"
}
