output "code_pipeline_service_role_arn" {
  value = "${aws_iam_role.code_pipeline_service_role.arn}"
}

output "code_deploy_service_role_arn" {
  value = "${aws_iam_role.code_deploy_service_role.arn}"
}

output "code_deploy_demo_ec2_instance_profile_role_arn" {
  value = "${aws_iam_role.code_deploy_demo_ec2_instance_profile_role.arn}"
}

output "code_deploy_demo_ec2_instance_profile_role_name" {
  value = "${aws_iam_role.code_deploy_demo_ec2_instance_profile_role.name}"
}

//output "s3read_codepipeline_policy_arn" {
//  value = "${aws_iam_policy.s3read_codepipeline.arn}"
//}
