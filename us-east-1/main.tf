data "aws_availability_zones" "all" {
  provider = "aws.specific-region"
}

data "aws_subnet_ids" "vpc" {
  provider = "aws.specific-region"
  vpc_id = "vpc-4dca0b29"
  //tags {
  //  Tier = "Private"
  //}
}

resource "aws_key_pair" "ec2_admin" {
  provider = "aws.specific-region"
  key_name   = "ec2-admin"
  public_key = "${var.ssh_public_key}"
}

module "code_pipeline_bucket" {
  source = "../lib/code-pipeline-artifact-bucket"
  region = "${var.aws_region}"
}

resource "aws_iam_role_policy_attachment" "s3read_codepipeline" {
  role       = "${var.instance_role_name}"
  policy_arn = "${module.code_pipeline_bucket.s3read_policy_arn}"
}

resource "random_shuffle" "db_az" {
  input = ["${data.aws_availability_zones.all.names}"]
  result_count = 1
}

module "db" {
  source = "./db"
  availability_zone = "${random_shuffle.db_az.result[0]}"
}

module "drupal6_app" {
  source = "../lib/drupal6-app"
  service_name = "d6-test"
  region = "${var.aws_region}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  vpc_subnet_ids = ["${data.aws_subnet_ids.vpc.ids}"]
  ssh_key_name = "${aws_key_pair.ec2_admin.key_name}"

  production_instance_type = "t2.nano"
  production_min_instances = 2
  production_max_instances = 4

  stage_instance_type = "t2.nano"
  stage_min_instances = 2

  code_pipeline_service_role = "arn:aws:iam::536179965220:role/AWS-CodePipeline-Service"
  code_pipeline_artifact_bucket_name = "${module.code_pipeline_bucket.bucket_name}"
  code_deploy_service_role = "${var.code_deploy_service_role_arn}"
}
