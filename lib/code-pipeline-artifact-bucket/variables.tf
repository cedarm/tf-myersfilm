variable "region" {}

resource "random_id" "uniq_id" {
  byte_length = 4
}
