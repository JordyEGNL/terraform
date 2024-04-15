terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker" # https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs
            version = "~> 3.0.2"
        }
    }
}

provider "docker" {}

resource "docker_image" "nginx" {
    name = "nginx:1.25.4" # https://hub.docker.com/_/nginx
}

resource "docker_container" "nginx" {
    image   = docker_image.nginx.image_id
    name    = "webserver-01"
    ports {
        internal = 80
        external = 8080
    }
}