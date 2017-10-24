data "aws_region" "current" {
  current = true
}

data "aws_subnet_ids" "default_vpc" {
  vpc_id = "vpc-4dca0b29"
  //tags {
  //  Tier = "Private"
  //}
}

module "iam" {
  source = "../iam"
}
output "code_pipeline_service_role_arn" {
  value = "${module.iam.code_pipeline_service_role_arn}"
}
output "s3read_codepipeline_arn" {
  value = "${aws_iam_policy.s3read_codepipeline.arn}"
}
output "code_deploy_demo_ec2_instance_profile_role_arn" {
  value = "${module.iam.code_deploy_demo_ec2_instance_profile_role_arn}"
}

module "code_pipeline_bucket" {
  source = "../lib/s3-bucket-for-code-pipeline"
  region = "${data.aws_region.current.name}"
}

resource "aws_iam_policy" "s3read_codepipeline" {
  name        = "S3Read-codepipeline"
  path        = "/"
  description = "Allow reading S3 Code Pipeline artifacts"
  policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "s3:Get*",
            "s3:List*"
          ],
          "Resource": [
            "${module.code_pipeline_bucket.bucket_arn}/*"
          ]
        }
      ]
    }
  EOF
}

resource "aws_iam_role_policy_attachment" "s3read_codepipeline" {
  role       = "${module.iam.code_deploy_demo_ec2_instance_profile_role_name}"
  policy_arn = "${aws_iam_policy.s3read_codepipeline.arn}"
}

module "db" {
  source = "./db"
}

/*
module "efs" {
  source = "../lib/efs"
  service_name = "drupal-shared-${data.aws_region.current.name}"
  mount_target_subnets = ["${data.aws_subnet_ids.default_vpc.ids}"]
  //extra_security_groups = ["sg-0a661278"] // blackhole
}
output "efs_dns_name" {
  value = "${module.efs.dns_name}"
}
output "efs_security_group_id" {
  value = "${module.efs.security_group_id}"
}
*/

module "drupal6_app" {
  source = "../lib/drupal6-app"
  service_name = "d6-test"
  vpc_id = "vpc-4dca0b29"

  production_instance_type = "t2.nano"
  production_min_instances = 2
  production_max_instances = 4

  stage_instance_type = "t2.nano"
  stage_min_instances = 2

  code_pipeline_service_role = "arn:aws:iam::536179965220:role/AWS-CodePipeline-Service"
  code_pipeline_artifact_bucket_name = "${module.code_pipeline_bucket.bucket_name}"
  code_deploy_service_role = "${module.iam.code_deploy_service_role_arn}"
}
