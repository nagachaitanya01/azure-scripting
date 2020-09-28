provider "azurerm" {
  subscription_id = "XXXXXXXXXXX"
  client_id       = "YYYYYYYYYYYYYYYYYYYY"
  client_secret   = "AAAAAAAAAAAAAAAAAAAAAAAAA"
  tenant_id       = "BBBBBBBBBBBBBBBBBBBBBBB"

  features {}
}

module myproj1 {
  source = "./modules"
rg1-name = "DEV-RG1"
location = "eastus"
saccount1 = "asdasdeasdeasdeaddd"
account_tier = "Standard"
replication = "LRS"
cidrs =  ["10.1.1.0/24","10.1.2.0/24","10.1.3.0/24"]
names = ["engazb02accont1", "engazb02accont2","engazb02accont3"]
foreachnames =  ["engazb02accont50","engazb02accont10", "engazb02accont20"]
env = "DEV"
  
}
