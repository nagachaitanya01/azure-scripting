resource "azurerm_storage_account" "engazureb02-saccount1" {
  name                     = var.saccount1
  resource_group_name      = azurerm_resource_group.ENG-AZURE-B02-1.name
  location                 = azurerm_resource_group.ENG-AZURE-B02-1.location
  account_tier             = var.account_tier
  account_replication_type = var.replication

  tags = {
    environment = "staging"
  }
}
