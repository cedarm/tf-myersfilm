variable "env" {}
variable "region" {}
variable "service_name" {}
variable "uniq_id" {}

variable "availability_zones" {
  type = "list"
}

variable "server_port" {
  default = 80
}

variable "instance_type" {
  default = "t2.micro"
}

variable "min_instances" {
  default = 1
}

variable "max_instances" {
  default = 4
}

variable "user_data" {
  default = ""
}

resource "random_id" "uniq_id" {
  keepers = {
    service_name = "${var.service_name}"
    env      = "${var.env}"
  }
  byte_length = 4
}
