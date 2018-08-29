module "drupal_shared" {
  source = "../../lib/rds"
  service_name = "drupal-shared"
  uniq_id = "${var.uniq_id}"

  engine = "postgres"
  engine_version = "9.6.3"

  instance_class = "db.t2.small"
  availability_zone = "${var.availability_zone}"
  multi_az = "false"
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  //vpc_security_group_ids = ["sg-0a661278"] // blackhole

  master_username = "postgres"
  master_password = "${random_id.drupal_shared_password.b64}"

  storage_encrypted = "true"
  storage_type = "gp2"
  allocated_storage = "5"

  backup_window = "08:15-09:15"
  maintenance_window = "sun:09:45-sun:10:45"
}

resource "aws_security_group" "sg" {
  name = "postgres"

  ingress {
    from_port = "5432"
    to_port = "5432"
    protocol = "tcp"
    security_groups = ["${var.allow_from_security_groups}"]
    description = "allow from specific security groups"
  }
}
