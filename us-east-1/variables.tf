variable "aws_profile" {}
variable "aws_region" {}
variable "ssh_public_key" {}
variable "code_deploy_service_role_arn" {}

variable "default_vpc_id" {
  default = "vpc-4dca0b29"
}
