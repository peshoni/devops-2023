terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}
provider "docker" {}
##########################################################
# Network
resource "docker_network" "private_network" {
  name = "exam-network"
}
##########################################################
# Images
resource "docker_image" "img-zookeeper" {
  name = "bitnami/zookeeper:latest"
}
resource "docker_image" "img-kafka" {
  name = "bitnami/kafka:latest"
}
resource "docker_image" "img-exporter" {
  name = "danielqsj/kafka-exporter"
}
resource "docker_image" "img-kafka-prod" {
  name = "shekeriev/kafka-prod"
}
resource "docker_image" "img-kafka-cons" {
  name = "shekeriev/kafka-cons"
}
resource "docker_image" "img-prometheus" {
  name = "prom/prometheus"
}
resource "docker_image" "img-grafana" {
  name = "grafana/grafana"
}

##########################################################
# Containers
# ZOOKEEPER
resource "docker_container" "zookeeper" {
  name  = "zookeeper"
  image = docker_image.img-zookeeper.image_id
  env   = ["ALLOW_ANONYMOUS_LOGIN=yes"]
  ports {
    internal = 2181
    external = 2181
  }
  networks_advanced {
    name = docker_network.private_network.name
  }
  restart = "on-failure"
}
# KAFKA
resource "docker_container" "kafka" {
  name  = "kafka"
  image = docker_image.img-kafka.image_id
  env = ["KAFKA_BROKER_ID=1",
    "KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181",
  "ALLOW_PLAINTEXT_LISTENER=yes"]
  ports {
    internal = 9092 # var.v_web_int_port
    external = 9092 #var.v_web_ext_port
  }
  networks_advanced {
    name = docker_network.private_network.name
  }
  depends_on = [
    docker_container.zookeeper
  ]
  restart = "on-failure"
}
# KAFKA EXPORTER
resource "docker_container" "exporter" {
  name  = "exporter"
  image = docker_image.img-exporter.image_id
  env   = ["kafka.server=kafka:9092"]

  ports {
    internal = 9308
    external = 9308
  }
  networks_advanced {
    name = docker_network.private_network.name
  }
  depends_on = [
    docker_container.kafka
  ]
  restart = "on-failure"
}
# Producer
resource "docker_container" "kafka-producer" {
  name  = "kafka-producer"
  image = docker_image.img-kafka-prod.image_id
  env   = ["BROKER=kafka:9092", "TOPIC=exam"]
  networks_advanced {
    name = docker_network.private_network.name
  }
  depends_on = [
    docker_container.kafka
  ]
  restart = "on-failure"
}
# Consumer
resource "docker_container" "kafka-consumer" {
  name  = "kafka-consumer"
  image = docker_image.img-kafka-cons.image_id
  env   = ["BROKER=kafka:9092", "TOPIC=exam"]
  networks_advanced {
    name = docker_network.private_network.name
  }
  depends_on = [
    docker_container.kafka
  ]
  restart = "on-failure"
}
# Prometheus
resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = docker_image.img-prometheus.image_id
  ports {
    internal = 9090
    external = 9090
  }
  networks_advanced {
    name = docker_network.private_network.name
  }
  volumes {
    host_path      = "/vagrant/terraform-docker/prometheus.yml"
    container_path = "/etc/prometheus/prometheus.yml"
    read_only      = true
  }
  depends_on = [
    docker_container.exporter
  ]
}
# Grafana
resource "docker_container" "grafana" {
  name  = "grafana"
  image = docker_image.img-grafana.image_id
  ports {
    internal = 3000
    external = 3000
  }
  networks_advanced {
    name = docker_network.private_network.name
  }
  volumes {
    host_path      = "/vagrant/terraform-docker/datasource.yml"
    container_path = "/etc/grafana/provisioning/datasources/datasource.yml"
    read_only      = true
  }
  depends_on = [
    docker_container.prometheus
  ]
}
##########################################################
