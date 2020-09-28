# 3 Machines for PROD and 1 for DEV
locals {
    common_tags = {
    batch = "B-02"
    lang = "English"
    startdate = "June 6th"
}
}

resource "azurerm_network_interface" "main" {
  count = "${var.env == "PROD" ?  3 : 1}"   ===============if it is PROD it creats 3 netinterfaces based on env in variables 
  name                = "testvmnic-${count.index+1}"
  resource_group_name = azurerm_resource_group.ENG-AZURE-B02-1.name
  location            = azurerm_resource_group.ENG-AZURE-B02-1.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${element(azurerm_subnet.VNET1-Subnet1.*.id, count.index)}"
    private_ip_address_allocation = "Dynamic"
  }
  tags = local.common_tags    =================================================>this from above local code
}


resource "azurerm_linux_virtual_machine" "main" {
  count = "${var.env == "PROD" ?  3 : 1}"
  name                            = "testvm-${count.index+1}"
  resource_group_name             = azurerm_resource_group.ENG-AZURE-B02-1.name
  location                        = azurerm_resource_group.ENG-AZURE-B02-1.location
  size                            = "${lookup(var.vm_type, var.env)}"
  admin_username                  = "adminuser"
  admin_password                  = "P@ssw0rd1234!"
  disable_password_authentication = false
  network_interface_ids = [
    "${element(azurerm_network_interface.main.*.id, count.index)}"
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk { 
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  tags = local.common_tags
}