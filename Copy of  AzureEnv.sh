#!/bin/bash
az group create -l eastus -n AzureClassRG
az network vnet create -g AzureClassRG -n EastUS-vNET1 --address-prefix 10.1.0.0/16 \
            --subnet-name vNET1-Subnet-1 --subnet-prefix 10.1.1.0/24 -l eastus

az network vnet create -g AzureClassRG -n EastUS-vNET2 --address-prefix 10.2.0.0/16 \
--subnet-name vNET2-Subnet-1 --subnet-prefix 10.2.1.0/24 -l eastus

az network vnet create -g AzureClassRG -n West-vNET1 --address-prefix 192.168.0.0/16 \
--subnet-name West-vNET1-Subnet-1 --subnet-prefix 192.168.1.0/24 -l westus

az network vnet create -g AzureClassRG -n West-vNET2 --address-prefix 172.16.0.0/16 \
--subnet-name West-vNET2-Subnet-1 --subnet-prefix 172.16.1.0/24 -l westus

az vm create --resource-group AzureClassRG --name TestVM1 --image UbuntuLTS --vnet-name EastUS-vNET1 \
--subnet vNET1-Subnet- --admin-username testuser --generate-ssh-keys --size Standard_B1ms

az vm create --resource-group AzureClassRG --name TestVM2 --image UbuntuLTS --vnet-name EastUS-vNET2 \
--subnet vNET2-Subnet-1 --admin-username testuser --generate-ssh-keys --size Standard_B1ms

##########################################################################################################
#!/bin/bash
#################---RG & vNET---###########
az group create -l eastus -n HUBRG
az network vnet create -g HUBRG -n HUBRG-vNET1 --address-prefix 10.1.0.0/16 \
--subnet-name HUBRG-Subnet-1 --subnet-prefix 10.1.1.0/24 -l eastus
#################---NSG_&_Rule_AvailibilitySet---###########
az network nsg create -g HUBRG -n HUBRG_NSG1
az network nsg rule create -g HUBRG --nsg-name HUBRG_NSG1 -n HUBRG_NSG1_RULE1 --priority 100 \
--source-address-prefixes '*' --source-port-ranges '*'     --destination-address-prefixes '*' \
--destination-port-ranges '*' --access Allow     --protocol Tcp --description "Allow from specific IP address ranges on 80 and 8080."
az vm availability-set create --name EAST-AVSET1 -g HUBRG --location eastus
#################---VIRTUALMACHINES---###########
az vm create --resource-group HUBRG --name HUBRGTestVM1 --image UbuntuLTS --vnet-name HUBRG-vNET1 \
--subnet HUBRG-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B1ms \
--availability-set EAST-AVSET1 --nsg HUBRG_NSG1 --custom-data cloud-init.txt

az vm create --resource-group HUBRG --name HUBRGTestVM2 --image UbuntuLTS --vnet-name HUBRG-vNET1 \
--subnet HUBRG-Subnet-1 --admin-username testuser --admin-password "India@123456" --size Standard_B1ms \
--availability-set EAST-AVSET1 --nsg HUBRG_NSG1 --custom-data cloud-init.txt

#cloud-config
package_upgrade: true
packages:
  - nginx

runcmd:
  - service nginx restart

https://stackoverflow.com/questions/32317506/get-pfx-from-crt-and-txt-containing-private-key
