provider "azurerm" {
    features {}
    subscription_id="ac6e8c49-833e-427d-bcc4-87042af5ddaf"
}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg"{
    name = "18557_resourcegroup"
}

data "azurerm_virtual_network" "vnet" {
    name = "yc-vnet"
    resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_app_service_plan" "asp"{
    name = "capstone-asp"
    location = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
    kind = "Linux"
    reserved = true
    sku{
        tier= "Basic"
        size= "B1"
    }
    tags = {
        environment = "prod"
        owner = "shejal"
        project = "capstone"
    }
}

resource "azurerm_app_service" "app" {
    name = "azure-capstone-app"
    location = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
    app_service_plan_id = azurerm_app_service_plan.asp.id

    site_config{
        linux_fx_version = "NODE|18-lts"
    }
    
    app_settings = {
        WEBSITE_RUN_FROM_PACKAGE = "1"
    }

    tags = {
        environment = "prod"
        owner = "shejal"
        project = "capstone"
    }
}

resource "azurerm_subnet" "app_subnet" {
    name = "appservice-subnet"
    virtual_network_name = data.azurerm_virtual_network.vnet.name
    resource_group_name = data.azurerm_resource_group.rg.name
    address_prefixes = ["10.10.3.0/24"]
    delegation {
        name = "appservice-delegation"
        service_delegation {
            name = "Microsoft.Web/serverFarms"
            actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
    }
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration"{
    app_service_id = azurerm_app_service.app.id
    subnet_id= azurerm_subnet.app_subnet.id
}

output "app_service_url" {
    value = azurerm_app_service.app.default_site_hostname
}