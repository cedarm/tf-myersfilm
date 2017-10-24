output "dns_name" {
  value = "${aws_efs_file_system.fs.dns_name}"
}

output "security_group_id" {
  value = "${aws_security_group.sg.id}"
}
