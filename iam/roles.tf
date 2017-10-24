resource "aws_iam_role" "code_pipeline_service_role" {
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
  role = "${aws_iam_role.code_pipeline_service_role.name}"
  policy_arn = "${aws_iam_policy.codepipeline_service.arn}"
}

resource "aws_iam_role" "code_deploy_service_role" {
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

resource "aws_iam_role" "code_deploy_demo_ec2_instance_profile_role" {
  name = "CodeDeployDemo-EC2-Instance-Profile"
  path = "/"
  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "test_attach" {
  role = "${aws_iam_role.code_deploy_demo_ec2_instance_profile_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployReadOnlyAccess"
}
