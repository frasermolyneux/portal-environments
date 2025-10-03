resource "azurerm_key_vault_secret" "config_secret" {
  for_each = { for each in local.config_secret_keys : each.key => each }

  name         = lower(replace(each.value.key_name, ":", "-"))
  value        = "placeholder"
  key_vault_id = azurerm_key_vault.config_kv[each.value.label].id

  content_type = "text/plain"

  expiration_date = each.value.expiration

  lifecycle {
    ignore_changes = [value]
  }
}
