variable "region" {}
variable "service_name" {}
variable "code_pipeline_service_role" {}
variable "code_pipeline_artifact_bucket_name" {}
variable "code_deploy_service_role" {}

variable "vpc_subnet_ids" {
  type = "list"
}

variable "availability_zones" {
  type = "list"
}

variable "production_instance_type" {
  default = "t2.micro"
}

variable "production_min_instances" {
  default = 1
}

variable "production_max_instances" {
  default = 4
}

variable "stage_instance_type" {
  default = "t2.micro"
}

variable "stage_min_instances" {
  default = 1
}

variable "stage_max_instances" {
  default = 4
}

resource "random_id" "uniq_id" {
  keepers = {
    service_name = "${var.service_name}"
  }
  byte_length = 4
}
