module "elb" {
  source = "../../elb"
  service_name = "${var.service_name}"
  uniq_id = "${random_id.uniq_id.dec}"
  env = "${var.env}"
  availability_zones = "${var.availability_zones}"
}

module "asg" {
  source = "../../asg"
  service_name = "${var.service_name}"
  uniq_id = "${random_id.uniq_id.dec}"
  env = "${var.env}"
  availability_zones = "${var.availability_zones}"
  elb_name = "${module.elb.elb_name}"
  ssh_key_name = "${var.ssh_key_name}"

  instance_type = "${var.instance_type}"
  min_instances = "${var.min_instances}"
  max_instances = "${var.max_instances}"

  user_data = "${data.template_file.amazon_linux_instance_setup.rendered}"
}

module "efs" {
  source = "../../efs"
  env = "${var.env}"
  region = "${var.region}"
  service_name = "${var.service_name}"
  uniq_id = "${random_id.uniq_id.dec}"
  mount_target_subnets = ["${var.vpc_subnet_ids}"]
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
