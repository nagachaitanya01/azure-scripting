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


variable "vnetname" {
    type = string
    description = "Deployment Location"
    #default = "eastus"
}

variable "vnetcidr" {
    type = string
    description = "Deployment Location"
    #default = "eastus"
}

variable "cidrs" {
    type = list
    description = "CIDR Blocks for Subnets"
    #default = ["10.1.1.0/24","10.1.2.0/24","10.1.3.0/24","10.1.4.0/24","10.1.5.0/24","10.1.6.0/24","10.1.7.0/24"]
}