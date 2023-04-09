terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {
  host = "tcp://192.168.99.100:2375/"
}

resource "docker_image" "bgapp-web" {
  name = var.v_web_image
}

resource "docker_image" "bgapp-db" {
  name = var.v_db_image
}

locals {
  root_path_tmp = "/${replace(abspath(path.root), ":", "")}"
  root_path     = replace(local.root_path_tmp, "////", "/")
}

resource "docker_container" "con-bgapp-web" {
  name  = var.v_web_con_name
  image = docker_image.bgapp-web.image_id

  networks_advanced {
    name = docker_network.private_network.name
  }

  # volumes {
  #   volume_name    = "data"
  #   host_path      = "${local.root_path}/web"
  #   container_path = "/var/www/html"
  #   read_only      = false
  # }

  mounts {
    type   = "bind"
    source = "${local.root_path}/web/"
    target = "/var/www/html"
  }

  ports {
    internal = var.v_web_int_port
    external = var.v_web_ext_port
  }

  depends_on = [
    docker_container.con-bgapp-db
  ]

  restart = "on-failure"
}

resource "docker_network" "private_network" {
  name = var.v_network_name
}

resource "docker_container" "con-bgapp-db" {
  name  = var.v_db_con_name
  image = docker_image.bgapp-db.image_id

  networks_advanced {
    name = docker_network.private_network.name
  }

  env = ["MYSQL_ROOT_PASSWORD=12345"]

  restart = "on-failure"
}



