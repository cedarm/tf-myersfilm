data "aws_subnet_ids" "default_vpc" {
  provider = "aws.specific-region"
  vpc_id = "vpc-4dca0b29"
  //tags {
  //  Tier = "Private"
  //}
}

module "code_pipeline_bucket" {
  source = "../lib/code-pipeline-artifact-bucket"
  region = "${var.aws_region}"
}

resource "aws_iam_role_policy_attachment" "s3read_codepipeline" {
  role       = "${var.instance_role_name}"
  policy_arn = "${module.code_pipeline_bucket.s3read_policy_arn}"
}

module "db" {
  source = "./db"
}

module "drupal6_app" {
  source = "../lib/drupal6-app"
  service_name = "d6-test"
  region = "${var.aws_region}"
  vpc_id = "vpc-4dca0b29"

  production_instance_type = "t2.nano"
  production_min_instances = 2
  production_max_instances = 4

  stage_instance_type = "t2.nano"
  stage_min_instances = 2

  code_pipeline_service_role = "arn:aws:iam::536179965220:role/AWS-CodePipeline-Service"
  code_pipeline_artifact_bucket_name = "${module.code_pipeline_bucket.bucket_name}"
  code_deploy_service_role = "${var.code_deploy_service_role_arn}"
}
