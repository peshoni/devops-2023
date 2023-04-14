variable "v_network_name" {
  description = "Network name"
  default     = "app-network"
}

variable "v_web_image" {
  description = "Image-web"
  default     = "shekeriev/bgapp-web"
}
variable "v_web_con_name" {
  description = "Container name"
  default     = "bg-app-web"
}
variable "v_web_int_port" {
  description = "Internal port"
  default     = 80
}
variable "v_web_ext_port" {
  description = "External port"
  default     = 80
}

variable "v_db_image" {
  description = "Image-db"
  default     = "shekeriev/bgapp-db"
}

variable "v_db_con_name" {
  description = "Container name"
  default     = "bg-app-db"
}
