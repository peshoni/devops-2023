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

resource "null_resource" "files" {
  triggers = {
    web_image_id = docker_image.img-web.id
  }
  provisioner "remote-exec" {
    inline = [
      "sudo rm -rf /project || true",
      "sudo mkdir /project || true",
      "cd /project",
      "sudo git clone https://github.com/shekeriev/bgapp",
    ]
    connection {
      type     = "ssh"
      user     = "vagrant"
      password = "vagrant"
      host     = "192.168.99.100"
    }
  }
}

# locals {
#   root_path_tmp = "/${replace(abspath(path.root), ":", "")}"
#   root_path     = replace(local.root_path_tmp, "////", "/")
# }

resource "docker_network" "private_network" {
  name = var.v_network_name
}

resource "docker_image" "img-web" {
  name = "shekeriev/bgapp-web"
}
resource "docker_image" "img-db" {
  name = "shekeriev/bgapp-db"
}

resource "docker_container" "con-bgapp-web" {
  name  = "web"
  image = docker_image.img-web.image_id

  networks_advanced {
    name = docker_network.private_network.name
  }

  volumes {
    host_path      = "/project/bgapp/web"
    container_path = "/var/www/html"
    read_only      = true
  }

  # mounts {
  #   type   = "bind"
  #   source = "${local.root_path}/web/"
  #   target = "/var/www/html"
  # }

  ports {
    internal = var.v_web_int_port
    external = var.v_web_ext_port
  }

  depends_on = [
    null_resource.files,
    docker_container.con-bgapp-db
  ]

  restart = "on-failure"
}

resource "docker_container" "con-bgapp-db" {
  name  = "db"
  image = docker_image.img-db.image_id

  networks_advanced {
    name = docker_network.private_network.name
  }

  env = ["MYSQL_ROOT_PASSWORD=12345"]

  restart = "on-failure"
}



