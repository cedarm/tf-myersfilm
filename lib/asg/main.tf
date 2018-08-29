data "aws_ami" "amazon_linux" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-2017.09.*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }
}

resource "aws_launch_configuration" "launch_config" {
  name_prefix = "${var.service_name}-${var.env}-${var.uniq_id}-"

  image_id = "${data.aws_ami.amazon_linux.image_id}"

  instance_type = "${var.instance_type}"
  // spot_price = "0.001"
  security_groups = ["${aws_security_group.instances.id}"]
  key_name      = "${var.ssh_key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.profile.name}"

  user_data = "${var.user_data}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "instances" {
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

resource "aws_iam_role" "instance_role" {
  name = "${var.service_name}-${var.env}-${var.uniq_id}-instance-role"
  path = "/"
  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
    EOF
}

resource "aws_iam_instance_profile" "profile" {
  name = "${var.service_name}-${var.env}-${var.uniq_id}-instance-profile"
  role = "${aws_iam_role.instance_role.name}"
}

resource "aws_iam_role_policy_attachment" "ssm_parameter_store" {
  role       = "${aws_iam_role.instance_role.name}"
  policy_arn = "${aws_iam_policy.ssm_parameter_store.arn}"
}

resource "aws_iam_policy" "ssm_parameter_store" {
  name = "${var.service_name}-${var.env}-${var.uniq_id}-ssm-parameter-store"
  path        = "/"
  description = "Allow access to SSM parameter store (specific prefix)"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:DescribeParameters"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:GetParameter",
        "ssm:GetParameters",
        "ssm:GetParametersByPath"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:us-west-2:536179965220:parameter/d6-test-2371264711",
        "arn:aws:ssm:us-west-2:536179965220:parameter/d6-test-2371264711/*",
        "arn:aws:ssm:us-west-2:536179965220:parameter/d6-test-4282691314/Staging",
        "arn:aws:ssm:us-west-2:536179965220:parameter/d6-test-4282691314/Staging/*",
        "arn:aws:ssm:us-west-2:536179965220:parameter/d6-test-4282691314/Production",
        "arn:aws:ssm:us-west-2:536179965220:parameter/d6-test-4282691314/Production/*"
      ]
    },
    {
      "Effect":"Allow",
      "Action":[
        "kms:Decrypt"
      ],
      "Resource":[
        "arn:aws:kms:us-west-2:536179965220:key/ef6deab0-0916-41ff-9a32-9abd65c0ed00"
      ]
    }
  ]
}
EOF
}

resource "aws_autoscaling_group" "asg" {
  name = "${var.service_name}-${var.env}-${var.uniq_id}"
  launch_configuration = "${aws_launch_configuration.launch_config.id}"
  availability_zones = ["${var.availability_zones}"]

  min_size = "${var.min_instances}"
  max_size = "${var.max_instances}"

  //load_balancers = ["${var.elb_name}"]
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
