resource "azuread_group" "sql_admin_group" {
  display_name     = local.sql_admin_group_name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true

  administrative_unit_ids = [local.workload_administrative_unit.administrative_unit_object_id]
}

resource "azuread_group_member" "sql_admins" {
  for_each = { for principal_name in var.sql_admin_aad_group_members : principal_name => principal_name }

  group_object_id  = azuread_group.sql_admin_group.object_id
  member_object_id = data.azuread_service_principal.sql_admin_members[each.value].object_id
}
