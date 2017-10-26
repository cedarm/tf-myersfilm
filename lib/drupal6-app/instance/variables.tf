variable "env" {}
variable "region" {}
variable "service_name" {}
variable "s3read_code_pipeline_policy_arn" {}

variable "vpc_subnet_ids" {
  type = "list"
}

variable "availability_zones" {
  type = "list"
}

variable "ssh_key_name" {
  default = ""
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

resource "random_id" "uniq_id" {
  keepers = {
    service_name = "${var.service_name}"
  }
  byte_length = 4
}
