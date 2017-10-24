module "code_pipeline" {
  source = "../code-pipeline"
  pipeline_name = "${var.service_name}-${random_id.uniq_id.dec}"
  role_arn = "${var.code_pipeline_service_role}"
  artifact_bucket_name = "${var.code_pipeline_artifact_bucket_name}"

  repo_owner = "cedarm"
  repo_name = "aws-codepipeline-s3-aws-codedeploy_linux"
  repo_branch = "master"

  app_name = "${var.service_name}-${random_id.uniq_id.dec}"
  stage_deployment_group_name = "${module.code_deploy.stage_deployment_group_name}"
  production_deployment_group_name = "${module.code_deploy.production_deployment_group_name}"
}

module "code_deploy" {
  source = "../code-deploy"
  app_name = "${var.service_name}-${random_id.uniq_id.dec}"

  stage_asg_list = ["${module.stage.asg_name}"]
  stage_elb_name = "${module.stage.elb_name}"

  production_asg_list = ["${module.production.asg_name}"]
  production_elb_name = "${module.production.elb_name}"

  service_role = "${var.code_deploy_service_role}"
}

module "production" {
  source = "./instance"
  service_name = "${var.service_name}"

  env = "production"
  region = "${var.region}"
  vpc_subnet_ids = ["${var.vpc_subnet_ids}"]
  availability_zones = "${var.availability_zones}"

  instance_type = "${var.production_instance_type}"
  min_instances = "${var.production_min_instances}"
  max_instances = "${var.production_max_instances}"
}

module "stage" {
  source = "./instance"
  service_name = "${var.service_name}"

  env = "stage"
  region = "${var.region}"
  vpc_subnet_ids = ["${var.vpc_subnet_ids}"]
  availability_zones = "${var.availability_zones}"

  instance_type = "${var.stage_instance_type}"
  min_instances = "${var.stage_min_instances}"
  max_instances = "${var.stage_max_instances}"
}
