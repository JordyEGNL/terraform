terraform {
    required_providers {
        cloudflare = {
            source = "cloudflare/cloudflare" # https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs
            version = "~> 4.29.0"
        }

        azurerm = {
            source = "hashicorp/azurerm" # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
            version = "~> 3.99.0"
        }
    }
}

variable "cloudflare_email" {
    type = string
}

variable "cloudflare_api_key" {
    type = string
}

variable "cloudflare_zone_id" {
    type = string
}

provider "cloudflare" {
    email = var.cloudflare_email
    api_key = var.cloudflare_api_key
}

provider "azurerm" {
    features {}
}


resource "azurerm_resource_group" "example" {
    name     = "rg-webserver-demo01"
    location = "West Europe"
}

resource "azurerm_container_group" "example" {
    name                = "ci-webserver-demo01"
    resource_group_name = azurerm_resource_group.example.name
    location            = azurerm_resource_group.example.location

    os_type       = "Linux"

    container {
        name   = "c-webserver-demo01"
        image  = "nginx:1.25.4"
        cpu    = "0.5"
        memory = "1.5"

        ports {
            port     = 80
            protocol = "TCP"
        }

        ports {
            port     = 443
            protocol = "TCP"
        }
    }
}

resource "cloudflare_record" "www" {
    zone_id = var.cloudflare_zone_id
    name = "test01"
    value = azurerm_container_group.example.ip_address
    type = "A"
    proxied = false
}