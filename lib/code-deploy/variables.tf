variable "app_name" {}

variable "service_role" {}

variable "stage_deployment_group_name" {
  default = "Staging"
}

variable "stage_asg_list" {
  type = "list"
}

variable "stage_elb_name" {}

variable "production_deployment_group_name" {
  default = "Production"
}

variable "production_asg_list" {
  type = "list"
}

variable "production_elb_name" {}

/*
resource "random_id" "uniq_id" {
  keepers = {
    service_name = "${var.service_name}"
  }
  byte_length = 4
}
*/
