module "iam" {
  source = "./iam"
}
output "code_pipeline_service_role_arn" {
  value = "${module.iam.code_pipeline_service_role_arn}"
}

locals {
  ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDQASfBTGdeXAHyuclF+L+NHjExICaVK3MAS2QUUyQRksKhCHnPqNz48/HhNejjjtWuwE+E8+//I4qqAlvC9eW4HxoNaAjYFVL9kOR+i/W+Z72jFjJoi95zzhaVrWdCtUJmQGi5TdyyxXQwnGkOjE3bbG38QBvq3oWL5+rYCa5iUNQmJnEVw+VN6MIryhetwFWzKkYYbMPCJzX1hn8HiGOXaby8Ym4Th5lexw0u8kS8wJ0Y+g+X8I5SdB2zK21cqS8B3V+jQNPDGnlYRyblZvBZPXWlmrWArzChh8txZ09EzNhCRmEwItEv/aKqH3UWFrlR2Ja2dVF07l5y+jMe71fqXF3+t6BO2phOsDnBgYVDjbJp0iS/VM7bIE9zTW0z9k+tNYgLj+ZtITeja74d9viOiZE4tF0x9HKtXWlrrW9dTaF9pc/gziU5mKBtkXT8qSVmZ2WvVtWvg/9NDFQ7Hu4xovuGjvBHfbeVY6B9lendU2+MaewMwXWhDnB8LiJpL2fZgdliY8HRvJrQQWpJUB/2gu0vRF7idrTKTuWXrV7Oy8GuOuf0xBfx41vhZZjI9J5zYslKBoeLYwUWFpL0Au0Y6UzFVlxX3mrASg035AO2u13NPhfOrd8gFwSXCWT0hSVXW3L5dzq02j1QPDyhxGEID23J42RBrUWxluNsgyRG7w== myersfilm@aws"
}

module "us_west_2" {
  source = "./us-west-2"
  aws_profile = "myersfilm"
  aws_region = "us-west-2"
  ssh_public_key = "${local.ssh_public_key}"
  code_deploy_service_role_arn = "${module.iam.code_deploy_service_role_arn}"
}

module "us_east_1" {
  source = "./us-east-1"
  aws_profile = "myersfilm"
  aws_region = "us-east-1"
  ssh_public_key = "${local.ssh_public_key}"
  code_deploy_service_role_arn = "${module.iam.code_deploy_service_role_arn}"
}
