resource "azurerm_storage_account" "this" {
  name                     = var.docuseal_azure_storage_account_name
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier              = "Cool"
  account_kind             = "StorageV2"

  tags = var.azure_tags
}

resource "azurerm_storage_container" "this" {
  name                  = var.docuseal_azure_container
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}
