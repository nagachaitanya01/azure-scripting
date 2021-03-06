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

variable "cidrs" {
    type = list
    description = "CIDR Blocks for Subnets"
    default = ["10.1.1.0/24","10.1.2.0/24","10.1.3.0/24","10.1.4.0/24","10.1.5.0/24","10.1.6.0/24","10.1.7.0/24"]
}

variable "names" {
    type = list
    description = "Names for StorageAccount"
    default = ["engazb02accont1", "engazb02accont2","engazb02accont3", "engazb02accont4","engazb02accont5"]
        #            0                   1               2                      3                 4
}

variable "foreachnames" {
    type = list
    description = "Names for StorageAccount"
    default = ["engazb02accont50","engazb02accont10", "engazb02accont20","engazb02accont30", "engazb02accont40"]
        #            0                   1               2                      3                 4
}
variable "env" {
    type = string
    description = "LRS or GRS"
    default = "PROD"
}

variable "vm_type" {
  type = "map"
  default = {
    DEV = "Standard_B1s"
    PROD = "Standard_B1ls"
    }
}

