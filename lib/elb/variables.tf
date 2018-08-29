variable "service_name" {}
variable "uniq_id" {}

variable "vpc_id" {
  type = "string"
}

variable "subnets" {
  type = "list"
}

variable "server_port" {
  default = 80
}

variable "tags" {
  default = {}
}
