output "web-container-id" {
  value = docker_container.con-bgapp-web.id
}
output "web-container-name" {
  value = docker_container.con-bgapp-web.name
}

output "web-db-id" {
  value = docker_container.con-bgapp-db.id
}
output "web-db-name" {
  value = docker_container.con-bgapp-db.name
}
