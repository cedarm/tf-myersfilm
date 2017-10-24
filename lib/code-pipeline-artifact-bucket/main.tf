module "code_pipeline_bucket" {
  source = "../s3-bucket-for-code-pipeline"
  region = "${var.region}"
}

resource "aws_iam_policy" "s3read_codepipeline" {
  provider = "aws.specific-region"
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
