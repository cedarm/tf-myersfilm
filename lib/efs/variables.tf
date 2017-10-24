variable "env" {}
variable "service_name" {}
variable "uniq_id" {}

variable "encrypted" {
  default = "true"
}

variable "performance_mode" {
  default = "generalPurpose"
}

variable "mount_target_subnets" {
  type = "list"
}

variable "extra_security_groups" {
  default = []
}

variable "tags" {
  default = {}
}

resource "random_id" "creation_token" {
  byte_length = 16
}
