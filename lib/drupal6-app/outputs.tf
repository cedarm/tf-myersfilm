output "production_instance_security_group_id" {
  value = "${module.production.instance_security_group_id}"
}

output "stage_instance_security_group_id" {
  value = "${module.stage.instance_security_group_id}"
}
