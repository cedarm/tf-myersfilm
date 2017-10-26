resource "aws_codepipeline" "pipeline" {
  name = "${var.pipeline_name}"
  role_arn = "arn:aws:iam::536179965220:role/AWS-CodePipeline-Service"

  artifact_store {
    type     = "S3"
    location = "${var.artifact_bucket_name}"
  }

  stage {
    name = "Source"
    action {
      name = "Source"
      category = "Source"
      owner = "ThirdParty"
      provider = "GitHub"
      version = "1"
      output_artifacts = ["DeployPackage"]
      configuration {
        Owner = "${var.repo_owner}"
        Repo = "${var.repo_name}"
        Branch = "${var.repo_branch}"
        PollForSourceChanges = "true"
      }
    }
  }

  stage {
    name = "Staging"
    action {
      name = "Deploy-To-Stage"
      category = "Deploy"
      owner = "AWS"
      provider = "CodeDeploy"
      version = "1"
      input_artifacts = ["DeployPackage"]
      configuration {
        ApplicationName = "${var.app_name}"
        DeploymentGroupName = "${var.stage_deployment_group_name}"
      }
    }
  }

  stage {
    name = "Production"
    action {
      name = "Deploy-To-Production"
      category = "Deploy"
      owner = "AWS"
      provider = "CodeDeploy"
      version = "1"
      input_artifacts = ["DeployPackage"]
      configuration {
        ApplicationName = "${var.app_name}"
        DeploymentGroupName = "${var.production_deployment_group_name}"
      }
    }
  }
}
