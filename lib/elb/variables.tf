variable "service_name" {}
variable "uniq_id" {}

variable "availability_zones" {
  type = "list"
}

variable "server_port" {
  default = 80
}
