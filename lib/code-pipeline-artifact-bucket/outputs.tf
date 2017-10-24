output "bucket_arn" {
  value = "${aws_s3_bucket.bucket.arn}"
}

output "bucket_name" {
  value = "${aws_s3_bucket.bucket.id}"
}

output "s3read_policy_arn" {
  value = "${aws_iam_policy.s3read_codepipeline.arn}"
}
