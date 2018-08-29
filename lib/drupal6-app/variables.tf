variable "region" {}
variable "service_name" {}
variable "uniq_id" {}
variable "code_pipeline_service_role" {}
variable "code_pipeline_artifact_bucket_name" {}
variable "code_deploy_service_role" {}
variable "repo_owner" {}
variable "repo_name" {}
variable "repo_branch" {}

variable "vpc_id" {
  type = "string"
}

variable "elb_subnet_ids" {
  type = "list"
}

variable "asg_subnet_ids" {
  type = "list"
}

variable "efs_subnet_ids" {
  type = "list"
}

variable "ssh_key_name" {
  default = ""
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
