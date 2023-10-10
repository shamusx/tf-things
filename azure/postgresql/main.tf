data "azurerm_resource_group" "mpresourcegroup" {
  name = var.resource_group
}

resource "azurerm_postgresql_flexible_server" "tsb_db_server" {
  name                = "tsbdb-server"
  location            = data.azurerm_resource_group.mpresourcegroup.location
  resource_group_name = data.azurerm_resource_group.mpresourcegroup.name
  sku_name = "GP_Standard_D4s_v3"

  storage_mb                   = 32768
  administrator_login          = var.admin_user
  administrator_password       = var.admin_password
  version                      = var.postgresql_version
}

resource "azurerm_postgresql_flexible_server_database" "example" {
  name                = "tsbdb"
  server_id         = azurerm_postgresql_flexible_server.tsb_db_server.id
  charset             = "UTF8"
  collation           = "en_US.utf8"
}