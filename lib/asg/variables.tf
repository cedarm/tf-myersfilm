variable "service_name" {}
variable "uniq_id" {}
variable "elb_name" {}

variable "availability_zones" {
  type = "list"
}

variable "ssh_key_name" {
  default = ""
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

variable "tags" {
  default = []
}
