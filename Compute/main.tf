terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.97.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscriptionid
  client_id       = var.clientid
  client_secret   = var.clientsecret
  tenant_id       = var.tenentid
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.RG_name
  location = var.location
}

#Create vnet
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_network_security_group" "nsg" {
  name                = var.securitygroup
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

}
resource "azurerm_network_security_rule" "nsg" {
  name                        = "rdp"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}
resource "azurerm_subnet_network_security_group_association" "nsg_subnet_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface" "nic" {
  count               = var.count
  name                = var.nic + "${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet7.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  count               = var.count
  name                = var.vmname + "${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vmsize
  admin_username      = var.vmusername
  admin_password      = var.vmpassword
  disable_password_authentication = false
  network_interface_ids = [element(azurerm_network_interface.nic.*.id, count.index)]
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.OSImagepublisher
    offer     = var.OSImageoffer
    sku       = var.OSImagesku
    version   = "latest"

  }
}