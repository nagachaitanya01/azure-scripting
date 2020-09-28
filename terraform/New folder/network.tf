resource "azurerm_virtual_network" "VNET1" {
  name                = "VNET1"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.ENG-AZURE-B02-1.name

  subnet {
    name           = "VNET1-Subnet1"
    address_prefix = "10.1.1.0/24"
  }
}

resource "azurerm_subnet" "VNET1-Subnet2" {
  name                 = "VNET1-Subnet2"
  resource_group_name  = azurerm_resource_group.ENG-AZURE-B02-1.name
  virtual_network_name = azurerm_virtual_network.VNET1.name
  address_prefixes     = ["10.1.2.0/24"]
}
