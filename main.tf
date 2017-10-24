module "iam" {
  source = "./iam"
}
output "code_pipeline_service_role_arn" {
  value = "${module.iam.code_pipeline_service_role_arn}"
}
//output "s3read_codepipeline_arn" {
//  value = "${aws_iam_policy.s3read_codepipeline.arn}"
//}
output "code_deploy_demo_ec2_instance_profile_role_arn" {
  value = "${module.iam.code_deploy_demo_ec2_instance_profile_role_arn}"
}

module "us_west_2" {
  source = "./us-west-2"
  aws_profile = "myersfilm"
  aws_region = "us-west-2"
  instance_role_name = "${module.iam.code_deploy_demo_ec2_instance_profile_role_name}"
  code_deploy_service_role_arn = "${module.iam.code_deploy_service_role_arn}"
}

module "us_east_1" {
  source = "./us-east-1"
  aws_profile = "myersfilm"
  aws_region = "us-east-1"
  instance_role_name = "${module.iam.code_deploy_demo_ec2_instance_profile_role_name}"
  code_deploy_service_role_arn = "${module.iam.code_deploy_service_role_arn}"
}
