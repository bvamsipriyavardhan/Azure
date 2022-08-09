variable "subscriptionid" {
  type        = string
  description = "Subsription ID"
}

variable "clientid" {
  type        = string
  description = "Subsription ID"
}

variable "clientsecret" {
  type        = string
  description = "Subsription ID"
}

variable "tenentid" {
  type        = string
  description = "Subsription ID"
}

variable "RG_name" {
  type        = string
  description = "The base of the name for the resource group and storage account"
}

variable "location" {
  type        = string
  description = "The location for the deployment"
}

variable "vnet" {
  type        = string
  description = "Virtual network name"
}


variable "subnet_name" {
  type        = string
  description = "vnet subnet name, it might be default or any name"
}


variable "securitygroup" {
  type        = string
  description = "Security Group Name"
}


variable "nic" {
  type        = string
  description = "Network Interface Name"
}

variable "nic" {
  type        = string
  description = "Network Interface Name"
}

variable "vmname" {
  type        = string
  description = "Virtual Machine Name Note: It should follow Azure vmname conditions"
}


variable "vmsize" {
  type        = string
  description = "vmsize"
}


variable "vmusername" {
  type        = string
  description = "vm username"
}

variable "vmpassword" {
  type        = string
  description = "vm password"
}

variable "OSImagepublisher" {
  type        = string
  description = "OS image publisher"
}

variable "OSImageoffer" {
  type        = string
  description = "OS Image offer"
}

variable "OSImagesku" {
  type        = string
  description = "OS Image sku"
}

