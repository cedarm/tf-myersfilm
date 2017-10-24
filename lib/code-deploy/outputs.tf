output "stage_deployment_group_name" {
  value = "${aws_codedeploy_deployment_group.stage_group.deployment_group_name}"
}

output "production_deployment_group_name" {
  value = "${aws_codedeploy_deployment_group.production_group.deployment_group_name}"
}
