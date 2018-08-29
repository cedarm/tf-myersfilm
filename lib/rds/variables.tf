variable "service_name" {}

variable "engine" {}

variable "engine_version" {}

variable "instance_class" {}

variable "multi_az" {
  default = "false"
}

variable "publicly_accessible" {
  default = "false"
}

variable "vpc_security_group_ids" {
  type = "list"
}

variable "availability_zone" {}

variable "skip_final_snapshot" {
  default = "false"
}

variable "auto_minor_version_upgrade" {
  default = "true"
}

variable "allow_major_version_upgrade" {
  default = "false"
}

variable "backup_window" {
  default = ""
}

variable "maintenance_window" {
  default = ""
}

variable "backup_retention_period" {
  default = 7
}

variable "storage_type" {
  default = "gp2"
}

variable "allocated_storage" {
  default = 20
}

variable "storage_encrypted" {
  default = "true"
}

variable "db_name" {
  default = "postgres"
}

variable "master_username" {
  default = "postgres"
}

variable "master_password" {}

resource "random_id" "uniq_id" {
  keepers = {
    service_name = "${var.service_name}"
  }
  byte_length = 4
}
