resource "aws_codebuild_project" "project" {
  name = "${var.app_name}"
  build_timeout = "60"
  service_role = "${aws_iam_role.codebuild_role.arn}"

  source {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/ubuntu-base:14.04"
    //image        = "wodby/drupal-php:5.6-2.3.0"
    type         = "LINUX_CONTAINER"

    //environment_variable {
    //  "name" = "NEWRELIC_API_KEY"
    //  "value" = "/CodeBuild/newrelic_api_key"
    //  "type" = "PARAMETER_STORE"
    //  "type" = "PLAINTEXT"
    //}
  }

  artifacts {
    type = "CODEPIPELINE"
  }
}

resource "aws_iam_role" "codebuild_role" {
//  name = "codebuild-role-"
//  name_prefix = "code-build-role-"
  name_prefix = "code-build-service-role-"
//  name = "code-build-example-service-role"
  path = "/service-role/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "codebuild_policy" {
  //name        = "codebuild-policy"
  name_prefix        = "codebuild-policy-"
//  name = "CodeBuildTrustPolicy-example-1509057946511"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodeBuild"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::codepipeline-us-west-2-*"
      ],
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:GetObjectVersion"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ssm:GetParameters"
      ],
      "Resource": "arn:aws:ssm:us-west-2:536179965220:parameter\/CodeBuild\/*"
    }
  ]
}
POLICY
/*
      "Resource": [
        "arn:aws:logs:us-west-2:536179965220:log-group:\/aws\/codebuild\/example",
        "arn:aws:logs:us-west-2:536179965220:log-group:\/aws\/codebuild\/example:*"
      ],

    {
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::codepipeline-us-west-2-*"
      ],
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:GetObjectVersion"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ssm:GetParameters"
      ],
      "Resource": "arn:aws:ssm:us-west-2:536179965220:parameter\/CodeBuild\/*"
    }
*/
}

resource "aws_iam_policy_attachment" "codebuild_policy_attachment" {
  name       = "codebuild-policy-attachment"
  policy_arn = "${aws_iam_policy.codebuild_policy.arn}"
  roles      = ["${aws_iam_role.codebuild_role.id}"]
}
