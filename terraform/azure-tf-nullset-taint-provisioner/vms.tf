# 3 Machines for PROD and 1 for DEV
locals {                               ======================>for giving tags
    common_tags = {
    batch = "B-02"
    lang = "English"
    startdate = "June 6th"
}
}

resource "azurerm_public_ip" "pips" {                 ============>for public ips
  count = "${var.env == "PROD" ?  3 : 1}"
  name                = "testpip-${count.index+1}"
  resource_group_name = azurerm_resource_group.ENG-AZURE-B02-1.name
  location            = azurerm_resource_group.ENG-AZURE-B02-1.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_interface" "main" {             ================>for craeing network interface
  count = "${var.env == "PROD" ?  3 : 1}"
  name                = "testvmnic-${count.index+1}"
  resource_group_name = azurerm_resource_group.ENG-AZURE-B02-1.name
  location            = azurerm_resource_group.ENG-AZURE-B02-1.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${element(azurerm_subnet.VNET1-Subnet1.*.id, count.index)}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${element(azurerm_public_ip.pips.*.id, count.index)}"
  }
  tags = local.common_tags
}


resource "azurerm_linux_virtual_machine" "main" {     ===========>for creating vm
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

provisioner "file" {        ===============>for running the myscript.sh file in specified destination 
  source      = "myscript.sh"
  destination = "/tmp/myscript.sh"

  connection {
    type     = "ssh"
    user     = "adminuser"
    password = "P@ssw0rd1234!"
    host     = "${element(azurerm_public_ip.pips.*.ip_address, count.index)}"
  }
}

}

resource "null_resource" "copyfile" {
  count = "${var.env == "PROD" ?  3 : 1}"
  provisioner "file" {
  source      = "myscript.sh"
  destination = "/tmp/myscript.sh"

  connection {
    type     = "ssh"
    user     = "adminuser"
    password = "P@ssw0rd1234!"
    host     = "${element(azurerm_public_ip.pips.*.ip_address, count.index)}"
  }
}
}
resource "null_resource" "myscript" {
  count = "${var.env == "PROD" ?  3 : 1}"
  provisioner "remote-exec" {
    inline = [

      "sudo bash /tmp/myscript.sh"
    ]
    connection {
    type     = "ssh"
    user     = "adminuser"
    password = "P@ssw0rd1234!"
    host     = "${element(azurerm_public_ip.pips.*.ip_address, count.index)}"
  }
  }
  depends_on = ["null_resource.copyfile"]
}

resource "null_resource" "samplefile" {
  count = "${var.env == "PROD" ?  3 : 1}"
  provisioner "file" {
  source      = "samplefile"
  destination = "/tmp/samplefile"

  connection {
    type     = "ssh"
    user     = "adminuser"
    password = "P@ssw0rd1234!"
    host     = "${element(azurerm_public_ip.pips.*.ip_address, count.index)}"
  }
}
}

resource "null_resource" "local-exec" {
  count = "${var.env == "PROD" ?  3 : 1}"
  provisioner "local-exec" {
    command = <<EOH
      echo "${element(azurerm_public_ip.pips.*.ip_address, count.index)}" >> ip_adderss, ========>all the public ips will be copied into the ip_adderss file after creation
      echo "${element(azurerm_linux_virtual_machine.main.*.name, count.index)}" >> hostnames,    ===========>all the hostnames will be copied into the hostaname file after creation
    EOH
  }
  
}

