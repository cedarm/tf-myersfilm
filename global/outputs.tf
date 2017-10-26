output "code_pipeline_service_role_arn" {
  value = "${module.iam.code_pipeline_service_role_arn}"
}

output "code_deploy_service_role_arn" {
  value = "${module.iam.code_deploy_service_role_arn}"
}
