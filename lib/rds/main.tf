resource "aws_db_instance" "db" {
  identifier              = "${var.service_name}-${random_id.uniq_id.dec}"
  engine                  = "${var.engine}"
  engine_version          = "${var.engine_version}"
  instance_class          = "${var.instance_class}"

  multi_az                = "${var.multi_az}"

  publicly_accessible     = "${var.publicly_accessible}"
  vpc_security_group_ids  = ["${var.vpc_security_group_ids}"]

  skip_final_snapshot     = "${var.skip_final_snapshot}"
  final_snapshot_identifier = "final-${var.service_name}-${random_id.uniq_id.dec}"

  availability_zone       = "${var.multi_az ? "" : var.availability_zone}"

  auto_minor_version_upgrade = "${var.auto_minor_version_upgrade}"
  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"

  backup_window           = "${var.backup_window}"
  maintenance_window      = "${var.maintenance_window}"
  backup_retention_period = "${var.backup_retention_period}"

  storage_type            = "${var.storage_type}"
  allocated_storage       = "${var.allocated_storage}"
  storage_encrypted       = "${var.storage_encrypted}"

  name                    = "${var.db_name}"
  username                = "${var.master_username}"
  password                = "${var.master_password}"

  //db_subnet_group_name    = "default"
  //parameter_group_name    = "default.postgres9.6"

  //tags {
  //  workload-type = "production"
  //}
}
