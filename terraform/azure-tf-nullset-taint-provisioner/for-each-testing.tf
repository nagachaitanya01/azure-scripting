resource "azurerm_storage_account" "for-each-test" {
  count = length(var.names)
  name                     = var.names[count.index]
  resource_group_name      = azurerm_resource_group.ENG-AZURE-B02-1.name
  location                 = azurerm_resource_group.ENG-AZURE-B02-1.location
  account_tier             = var.account_tier
  account_replication_type = var.replication

}

locals{
    images = { 
        for name in var.foreachnames : name => name }
}

resource "azurerm_storage_account" "for-each-test-actual" {
  for_each = local.images
  name                     = "${each.key}"
  resource_group_name      = azurerm_resource_group.ENG-AZURE-B02-1.name
  location                 = azurerm_resource_group.ENG-AZURE-B02-1.location
  account_tier             = var.account_tier
  account_replication_type = var.replication

}