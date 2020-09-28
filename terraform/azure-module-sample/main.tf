provider "azurerm" {
  subscription_id = "298f2c19-014b-4195-b821-e3d8fc25c2a8"
  client_id       = "9e54129d-a84c-43cc-b922-279e38159cf4"
  client_secret   = "5Wn2xKXC2bj-e8vZ_9YlnuMD0eL40_~DYW"
  tenant_id       = "2b387c91-acd6-4c88-a6aa-c92a96cab8b1"

  features {}
}

module "project-1" {
  source = "./modules/common_infra"
  rg1-name = "TESTRG-1"
  location = "eastus"
  vnetname = "TESTRG-VNET-1"
  vnetcidr = "10.1.0.0/16"
  cidrs = ["10.1.1.0/24","10.1.2.0/24","10.1.3.0/24"]
}

module "project-2" {
  source = "./modules/common_infra"
  rg1-name = "TESTRG-2"
  location = "eastus"
  vnetname = "TESTRG-VNET-2"
  vnetcidr = "10.1.0.0/16"
  cidrs = ["10.1.1.0/24","10.1.2.0/24","10.1.3.0/24"]
}

module "project-3" {
  source = "./modules/common_infra"
  rg1-name = "TESTRG-3"
  location = "eastus"
  vnetname = "TESTRG-VNET-3"
  vnetcidr = "10.1.0.0/16"
  cidrs = ["10.1.1.0/24","10.1.2.0/24","10.1.3.0/24"]
}
