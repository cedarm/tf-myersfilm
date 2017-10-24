module "asg" {
  source = "../../asg"
  service_name = "${var.service_name}"
  uniq_id = "${random_id.uniq_id.dec}"
  env = "${var.env}"

  instance_type = "${var.instance_type}"
  min_instances = "${var.min_instances}"
  max_instances = "${var.max_instances}"

  user_data = "${data.template_file.amazon_linux_instance_setup.rendered}"
}

module "efs" {
  source = "../../efs"
  env = "${var.env}"
  //service_name = "drupal-shared-${data.aws_region.current.name}"
  //service_name = "${var.service_name}-${data.aws_region.current.name}"
  service_name = "${var.service_name}"
  uniq_id = "${random_id.uniq_id.dec}"
  mount_target_subnets = ["${data.aws_subnet_ids.vpc.ids}"]
}

data "aws_region" "current" {
  current = true
}

data "aws_subnet_ids" "vpc" {
  vpc_id = "${var.vpc_id}"
}

data "template_file" "amazon_linux_instance_setup" {
  template = "${file("${path.module}/amazon-linux-instance-setup.sh.tpl")}"
  vars = {
    region = "${data.aws_region.current.name}"
    efs_dns_name = "${module.efs.dns_name}"
  }
}

data "template_file" "ubuntu_instance_setup" {
  template = "${file("${path.module}/ubuntu-instance-setup.sh.tpl")}"
  vars = {
    region = "${data.aws_region.current.name}"
    efs_dns_name = "${module.efs.dns_name}"
  }
}
