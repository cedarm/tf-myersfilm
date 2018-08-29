output "asg_name" {
  value = "${module.asg.asg_name}"
}

output "instance_security_group_id" {
  value = ["${module.asg.instance_security_group_id}"]
}

output "elb_name" {
  value = "${module.elb.elb_name}"
}

output "elb_dns_name" {
  value = "${module.elb.elb_dns_name}"
}
