output "asg_name" {
  value = "${aws_autoscaling_group.asg.name}"
}

output "elb_name" {
  value = "${aws_elb.elb.name}"
}
