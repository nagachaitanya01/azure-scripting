provider "azurerm" {
  subscription_id = "298f2c19-014b-4195-b821-e3d8fc25c2a8"
  client_id       = "9e54129d-a84c-43cc-b922-279e38159cf4"
  client_secret   = "5Wn2xKXC2bj-e8vZ_9YlnuMD0eL40_~DYW"
  tenant_id       = "2b387c91-acd6-4c88-a6aa-c92a96cab8b1"

  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "cloud-shell-storage-southeastasia"
    storage_account_name = "azureengb03tfstate"
    container_name       = "terraformstate"
    key                  = "myterraform.tfstate"
  }
}
