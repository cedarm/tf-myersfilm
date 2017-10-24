variable "availability_zone" {}

resource "random_id" "drupal_shared_password" {
  keepers = {
    service_name = "drupal-shared"
  }
  byte_length = 16
}
