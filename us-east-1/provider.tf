provider "aws" {
  alias = "specific-region"
  profile = "${var.aws_profile}"
  region = "${var.aws_region}"
}
