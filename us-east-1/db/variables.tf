variable "uniq_id" {}

variable "availability_zone" {}

variable "allow_from_security_groups" {
  default = []
}

resource "random_id" "drupal_shared_password" {
  keepers = {
    service_name = "drupal-shared"
  }
  byte_length = 16
}
