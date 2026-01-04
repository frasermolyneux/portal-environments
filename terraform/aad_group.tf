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

resource "azuread_group" "sql_repository_readers_group" {
  display_name     = local.sql_repository_readers_group_name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true

  administrative_unit_ids = [local.workload_administrative_unit.administrative_unit_object_id]
}

resource "azuread_group" "sql_repository_writers_group" {
  display_name     = local.sql_repository_writers_group_name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true

  administrative_unit_ids = [local.workload_administrative_unit.administrative_unit_object_id]
}

resource "azuread_group_member" "sql_repository_readers_repository_webapi_identity" {
  group_object_id  = azuread_group.sql_repository_readers_group.object_id
  member_object_id = azurerm_user_assigned_identity.managed["repository_webapi_identity"].principal_id
}

resource "azuread_group_member" "sql_repository_writers_repository_webapi_identity" {
  group_object_id  = azuread_group.sql_repository_writers_group.object_id
  member_object_id = azurerm_user_assigned_identity.managed["repository_webapi_identity"].principal_id
}
