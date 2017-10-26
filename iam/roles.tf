resource "aws_iam_role" "code_pipeline_service_role" {
  provider = "aws.default-region"
  name = "AWS-CodePipeline-Service"
  path = "/"
  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "",
          "Effect": "Allow",
          "Principal": {
            "Service": "codepipeline.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "code_pipeline_service" {
  provider = "aws.default-region"
  role = "${aws_iam_role.code_pipeline_service_role.name}"
  policy_arn = "${aws_iam_policy.codepipeline_service.arn}"
}

resource "aws_iam_role" "code_deploy_service_role" {
  provider = "aws.default-region"
  name = "CodeDeployServiceRole"
  path = "/"
  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "",
          "Effect": "Allow",
          "Principal": {
            "Service": "codedeploy.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
    EOF
}
