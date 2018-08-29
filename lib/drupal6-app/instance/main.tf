module "elb" {
  source = "../../elb"
  service_name = "${var.service_name}"
  uniq_id = "${var.uniq_id}"
  availability_zones = "${var.availability_zones}"
}

module "asg" {
  source = "../../asg"
  service_name = "${var.service_name}"
  uniq_id = "${var.uniq_id}"
  availability_zones = "${var.availability_zones}"
  elb_name = "${module.elb.elb_name}"
  ssh_key_name = "${var.ssh_key_name}"

  instance_type = "${var.instance_type}"
  min_instances = "${var.min_instances}"
  max_instances = "${var.max_instances}"

  user_data = "${data.template_file.amazon_linux_instance_setup.rendered}"
}

resource "aws_iam_role_policy_attachment" "code_deploy_ro" {
  role = "${module.asg.instance_role_name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "ec2_role_code_deploy" {
  role = "${module.asg.instance_role_name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

module "efs" {
  source = "../../efs"
  region = "${var.region}"
  service_name = "${var.service_name}"
  uniq_id = "${var.uniq_id}"
  mount_target_subnets = ["${var.vpc_subnet_ids}"]
  allow_from_security_groups = ["${module.asg.instance_security_group_id}"]
}

data "template_file" "amazon_linux_instance_setup" {
  template = "${file("${path.module}/amazon-linux-instance-setup.sh.tpl")}"
  vars = {
    region = "${var.region}"
    efs_dns_name = "${module.efs.dns_name}"
  }
}

data "template_file" "ubuntu_instance_setup" {
  template = "${file("${path.module}/ubuntu-instance-setup.sh.tpl")}"
  vars = {
    region = "${var.region}"
    efs_dns_name = "${module.efs.dns_name}"
  }
}
