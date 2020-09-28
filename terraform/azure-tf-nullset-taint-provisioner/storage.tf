resource "azurerm_storage_account" "engazureb02-saccount1" {
  name                     = var.saccount1
  resource_group_name      = azurerm_resource_group.ENG-AZURE-B02-1.name
  location                 = azurerm_resource_group.ENG-AZURE-B02-1.location
  account_tier             = var.account_tier
  account_replication_type = var.replication

  tags = {
    environment = "staging"
  }
  lifecycle {
    create_before_destroy = true
    #prevent_destroy = true
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}
