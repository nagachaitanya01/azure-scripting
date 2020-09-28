#!/bin/bash
#Creating Resource Groups
az group create -l eastus -n HUBRG
az group create -l eastus -n SPOKERG1
az group create -l eastus -n SPOKERG2

az group delete --name HUBRG --yes
az group delete --name SPOKERG1 --yes
az group delete --name SPOKERG2 --yes

#Creating vNETs
az network vnet create -g HUBRG -n HUBRG-vNET1 --address-prefix 10.1.0.0/16 \
--subnet-name HUBRG-Subnet-1 --subnet-prefix 10.1.1.0/24 -l eastus

az network vnet create -g SPOKERG1 -n SPOKERG1-vNET1 --address-prefix 192.168.0.0/16 \
--subnet-name SPOKERG1-Subnet-1 --subnet-prefix 192.168.1.0/24 -l eastus

az network vnet create -g SPOKERG2 -n SPOKERG2-vNET2 --address-prefix 172.16.0.0/16 \
--subnet-name SPOKERG2-Subnet-1 --subnet-prefix 172.16.1.0/24 -l eastus


#Create VMs
az vm create --resource-group HUBRG --name HUBRGTestVM1 --image UbuntuLTS --vnet-name HUBRG-vNET1 \
--subnet HUBRG-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B1ms

az vm create --resource-group SPOKERG1 --name SPOKERG1-VM1 --image UbuntuLTS --vnet-name SPOKERG1-vNET1 \
--subnet SPOKERG1-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B1ms

az vm create --resource-group SPOKERG2 --name SPOKERG2-VM1 --image UbuntuLTS --vnet-name SPOKERG2-vNET1 \
--subnet SPOKERG2-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B1ms
