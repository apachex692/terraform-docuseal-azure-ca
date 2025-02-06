resource "azurerm_storage_account" "this" {
  name                     = "attackdocuseal"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier              = "Cool"
  account_kind             = "StorageV2"

  tags = var.azure_tags
}
