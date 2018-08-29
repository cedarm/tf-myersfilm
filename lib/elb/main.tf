resource "aws_elb" "elb" {
  name = "${var.service_name}-${var.uniq_id}"
  subnets = ["${var.subnets}"]
  security_groups = ["${aws_security_group.elb.id}"]

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:${var.server_port}/"
  }

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "${var.server_port}"
    instance_protocol = "http"
  }

  tags = "${var.tags}"
}

resource "aws_security_group" "elb" {
  name = "elb-${var.service_name}-${var.uniq_id}"
  vpc_id = "${var.vpc_id}"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${var.tags}"
}
