locals {
  efs_name = "${var.service_name}-${var.env}-${var.uniq_id}-${var.region}"
}

resource "aws_efs_file_system" "fs" {
  provider = "aws.specific-region"
  creation_token = "${random_id.creation_token.hex}"
  performance_mode = "${var.performance_mode}"
  encrypted = "${var.encrypted}"
  tags = "${merge(var.tags, map("Name", local.efs_name))}"
}

resource "aws_efs_mount_target" "targets" {
  provider = "aws.specific-region"
  count = "${length(var.mount_target_subnets)}"
  file_system_id  = "${aws_efs_file_system.fs.id}"
  subnet_id       = "${var.mount_target_subnets[count.index]}"
  security_groups = ["${aws_security_group.sg.id}"]
}

resource "aws_security_group" "sg" {
  provider = "aws.specific-region"
  name = "efs-${var.service_name}-${var.env}-${var.uniq_id}"
  ingress {
    from_port = "2049"
    to_port = "2049"
    protocol = "tcp"
    security_groups = ["${var.allow_from_security_groups}"]
    description = "allow from specific ec2 instances"
  }
  tags = "${var.tags}"
}
