terraform {
    required_providers {
        proxmox = {
        source = "telmate/proxmox" # https://registry.terraform.io/providers/Telmate/proxmox/latest/docs
        version = "3.0.1-rc1"
        }
    }
}

provider "proxmox" {
    pm_api_url          = var.pm_api_url
    pm_api_token_id     = var.pm_api_token_id
    pm_api_token_secret = var.pm_api_token_secret

    pm_log_enable = true
    pm_log_file   = "terraform-plugin-proxmox.log"
    pm_debug      = true
    pm_log_levels = {
        _default    = "debug"
        _capturelog = " "
    }
}

variable "pm_api_url" {
    type = string
}

variable "pm_api_token_id" {
    type = string
}

variable "pm_api_token_secret" {
    type = string
}

