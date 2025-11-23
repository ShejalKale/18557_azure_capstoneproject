variable "resource_group_name" { default = "18557_resourcegroup" }
variable "location"            { default = "Central India" }
variable "vnet_name"           { default = "yc-vnet" }
variable "storage_account_name" { default = "18557azurecapstoneproj" }

variable "tags" {
  type = map(string)
  default = {
    environment = "prod"
    owner       = "shejal"
    project     = "capstone"
  }
}
