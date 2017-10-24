output "bucket_arn" {
  value = "${module.code_pipeline_bucket.bucket_arn}"
}

output "bucket_name" {
  value = "${module.code_pipeline_bucket.bucket_name}"
}

output "s3read_policy_arn" {
  value = "${aws_iam_policy.s3read_codepipeline.arn}"
}
