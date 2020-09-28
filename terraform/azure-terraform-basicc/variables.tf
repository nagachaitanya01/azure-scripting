variable "rg1-name" {
    type = string
    description = "Name for Resource Group 1"
    #default = "TESTRG1"
}

variable "location" {
    type = string
    description = "Deployment Location"
    #default = "eastus"
}

variable "saccount1" {
    type = string
    description = "Name of Storage Account 1"
    #default = "engazureb02saccount1"
}

variable "account_tier" {
    type = string
    description = "Standard or Premium"
    #default = "Standard"
}

variable "replication" {
    type = string
    description = "LRS or GRS"
    #default = "LRS"
}

