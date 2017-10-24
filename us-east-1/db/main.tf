module "drupal_shared" {
  source = "../../lib/rds"
  service_name = "drupal-shared"

  engine = "postgres"
  engine_version = "9.6.3"

  //instance_class = "db.t2.micro"
  instance_class = "db.t2.small"
  availability_zone = "us-east-1e"
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

  // TODO restrict to local subnets
  ingress {
    from_port = "5432"
    to_port = "5432"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0", "67.190.110.168/32"]
    description = "allow from anywhere"
  }
}
