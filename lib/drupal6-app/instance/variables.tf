variable "env" {}
variable "vpc_id" {}
variable "service_name" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "min_instances" {
  default = 1
}

variable "max_instances" {
  default = 4
}

resource "random_id" "uniq_id" {
  keepers = {
    service_name = "${var.service_name}"
  }
  byte_length = 4
}
