resource "aws_launch_configuration" "launch_config" {
  //name_prefix = "${var.service_name}-${var.env}-${random_id.uniq_id.dec}-"
  name_prefix = "${var.service_name}-${var.env}-${var.uniq_id}-"

  // image_id = "${lookup(var.RegionOS2AMI, var.Region)}"
  //   or see aws_ami data source
  image_id = "ami-8c1be5f6" // amazon linux
  //image_id = "ami-cd0f5cb6" // ubuntu

  instance_type = "${var.instance_type}"
  // spot_price = "0.001"
  security_groups = ["${aws_security_group.instances.id}"]
  key_name      = "cedarm-myersfilm-aws"
  iam_instance_profile = "CodeDeployDemo-EC2-Instance-Profile"

  //user_data = "${data.template_file.amazon_linux_instance_setup.rendered}"
  //user_data = "${data.template_file.ubuntu_instance_setup.rendered}"
  user_data = "${var.user_data}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "instances" {
  //name = "${var.service_name}-${var.env}-instances-${random_id.uniq_id.dec}"
  name = "${var.service_name}-${var.env}-instances-${var.uniq_id}"
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // TODO remove this
  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_availability_zones" "all" {}

data "aws_region" "current" {
  current = true
}

resource "aws_autoscaling_group" "asg" {
  //name = "${var.service_name}-${var.env}-${random_id.uniq_id.dec}"
  name = "${var.service_name}-${var.env}-${var.uniq_id}"
  launch_configuration = "${aws_launch_configuration.launch_config.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]

  min_size = "${var.min_instances}"
  max_size = "${var.max_instances}"

  load_balancers = ["${aws_elb.elb.name}"]
  health_check_type = "EC2"

  tag {
    key = "Name"
    value = "${var.service_name}-${var.env}"
    propagate_at_launch = true
  }
  tag {
    key = "Env"
    value = "${var.env}"
    propagate_at_launch = true
  }
}

resource "aws_elb" "elb" {
  //name = "${var.service_name}-${var.env}"
  //name = "${var.service_name}-${random_id.uniq_id.dec}"
  name = "${var.service_name}-${var.uniq_id}"
  security_groups = ["${aws_security_group.elb.id}"]
  availability_zones = ["${data.aws_availability_zones.all.names}"]

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

  tags {
    Env = "${var.env}"
  }
}

resource "aws_security_group" "elb" {
  //name = "${var.service_name}-elb-${var.env}-${random_id.uniq_id.dec}"
  //name = "${var.service_name}-elb-${var.env}-${var.uniq_id}"
  name = "elb-${var.service_name}-${var.env}-${var.uniq_id}"
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
}
