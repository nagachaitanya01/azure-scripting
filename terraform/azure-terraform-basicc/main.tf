provider "azurerm" {
  subscription_id = "298f2c19-014b-4195-b821-e3d8fc25c2a8"
  client_id       = "9e54129d-a84c-43cc-b922-279e38159cf4"
  client_secret   = "i~_ee5RN36LWc_mcO~2Yo8v-03-IF0xl6s"
  tenant_id       = "2b387c91-acd6-4c88-a6aa-c92a96cab8b1"

  features {}
}

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "ENG-AZUREB-02"
#     storage_account_name = "sreearmtemplates"
#     container_name       = "terraform"
#     key                  = "myterraform.tfstate"
#   }
# }
