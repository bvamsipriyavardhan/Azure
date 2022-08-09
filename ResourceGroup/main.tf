#This script will create New RG by taking variables from variable.tf file
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.88.1"
    }
  }

}
provider "azurerm" {
  features {}
  subscription_id = var.subscriptionid
  client_id       = var.clientid
  client_secret   = var.clientsecret
  tenant_id       = var.tenentid
}
resource "azurerm_resource_group" "New_RG" {
  name     = var.RG_name
  location = var.location
}
