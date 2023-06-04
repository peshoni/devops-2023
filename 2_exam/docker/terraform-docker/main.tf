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
  name = "appnet"
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
# Producer
resource "docker_image" "img-kafka-disc" {
  name = "shekeriev/kafka-discoverer"
}
# Consumer
resource "docker_image" "img-kafka-obs" {
  name = "shekeriev/kafka-observer"
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
    internal = 9092
    external = 9092
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
# Producer - Discoverer
resource "docker_container" "discoverer" {
  name  = "discoverer"
  image = docker_image.img-kafka-disc.image_id
  env   = ["BROKER=kafka:9092", "TOPIC=animal-facts", "METRICPORT=8000"] # Where to expose the metrics (PORT)

  ports {
    internal = 8000
    external = 8000
  }
  networks_advanced {
    name = docker_network.private_network.name
  }
  depends_on = [
    docker_container.kafka
  ]
  restart = "on-failure"
}
# Consumer - observer
resource "docker_container" "observer" {
  name  = "observer"
  image = docker_image.img-kafka-obs.image_id
  env   = ["BROKER=kafka:9092", "TOPIC=animal-facts", "APPPORT:5000"] # Sets the web interface (PORT)
  ports {
    internal = 5000
    external = 5000
  }
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
