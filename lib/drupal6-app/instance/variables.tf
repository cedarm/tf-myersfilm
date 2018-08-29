variable "region" {}
variable "service_name" {}
variable "uniq_id" {}

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

variable "tags" {
  default = {}
}

variable "asg_tags" {
  default = []
}
