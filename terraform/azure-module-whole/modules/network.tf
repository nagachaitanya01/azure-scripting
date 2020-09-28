resource "azurerm_virtual_network" "VNET1" {
  name                = "VNET1"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.ENG-AZURE-B02-1.name
}

resource "azurerm_subnet" "VNET1-Subnet1" {
  count = length(var.cidrs)
  name                 = "ENGB02-Subnet-${count.index+1}"
  resource_group_name  = azurerm_resource_group.ENG-AZURE-B02-1.name
  virtual_network_name = azurerm_virtual_network.VNET1.name
  address_prefixes     = ["${element(var.cidrs,count.index)}"]
}


