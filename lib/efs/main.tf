locals {
  efs_name = "${var.service_name}-${var.env}-${var.uniq_id}-${var.region}"
}

resource "aws_efs_file_system" "fs" {
  provider = "aws.specific-region"
  creation_token = "${random_id.creation_token.hex}"
  performance_mode = "${var.performance_mode}"
  encrypted = "${var.encrypted}"
  //tags = "${merge(var.tags, map("Name", var.service_name))}"
  tags = "${merge(var.tags, map("Name", local.efs_name))}"
}

resource "aws_efs_mount_target" "targets" {
  provider = "aws.specific-region"
  count = "${length(var.mount_target_subnets)}"
  file_system_id  = "${aws_efs_file_system.fs.id}"
  subnet_id       = "${var.mount_target_subnets[count.index]}"
  security_groups = ["${concat(list(aws_security_group.sg.id), var.extra_security_groups)}"]
  //security_groups = ["sg-0a661278"] // blackhole
}

resource "aws_security_group" "sg" {
  provider = "aws.specific-region"
  //name = "efs-${var.service_name}"
  //name = "efs-${var.service_name}-${var.uniq_id}"
  name = "efs-${var.service_name}-${var.env}-${var.uniq_id}"
  //name = "efs-${local.efs_name}"
  // TODO restrict to local subnets
  ingress {
    from_port = "2049"
    to_port = "2049"
    protocol = "tcp"
    cidr_blocks = ["67.190.110.168/32"]
    description = "allow from local subnets"
  }
  tags = "${var.tags}"
}
