/*
resource "random_id" "uniq_id" {
  keepers = {
    service_name = "${var.service_name}"
  }
  byte_length = 4
}
*/

resource "random_id" "drupal_shared_password" {
  keepers = {
    service_name = "drupal-shared"
  }
  byte_length = 16
}
