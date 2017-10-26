output "code_pipeline_service_role_arn" {
  value = "${aws_iam_role.code_pipeline_service_role.arn}"
}

output "code_deploy_service_role_arn" {
  value = "${aws_iam_role.code_deploy_service_role.arn}"
}
