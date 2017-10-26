output "asg_name" {
  value = "${aws_autoscaling_group.asg.name}"
}

output "instance_role_name" {
  value = "${aws_iam_role.instance_role.name}"
}

output "instance_profile_name" {
  value = "${aws_iam_instance_profile.profile.name}"
}

output "instance_security_group_id" {
  value = "${aws_security_group.instances.id}"
}
