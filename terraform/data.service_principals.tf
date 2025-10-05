data "azuread_service_principal" "sql_admin_members" {
  for_each = { for principal_name in var.sql_admin_aad_group_members : principal_name => principal_name }

  display_name = each.value
}
