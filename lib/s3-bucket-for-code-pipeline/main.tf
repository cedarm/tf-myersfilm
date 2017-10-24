resource "aws_s3_bucket" "bucket" {
  provider = "aws.specific-region"
  bucket = "codepipeline-${var.region}-${random_id.uniq_id.dec}"
  acl    = "private"

  tags {
    Name = "codepipeline-${var.region}"
  }
}

resource "aws_s3_bucket_policy" "bucket" {
  provider = "aws.specific-region"
  bucket = "${aws_s3_bucket.bucket.id}"
  policy =<<EOF
{
    "Version": "2012-10-17",
    "Id": "SSEAndSSLPolicy",
    "Statement": [
        {
            "Sid": "DenyUnEncryptedObjectUploads",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::codepipeline-${var.region}-${random_id.uniq_id.dec}/*",
            "Condition": {
                "StringNotEquals": {
                    "s3:x-amz-server-side-encryption": "aws:kms"
                }
            }
        },
        {
            "Sid": "DenyInsecureConnections",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::codepipeline-${var.region}-${random_id.uniq_id.dec}/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
}
EOF
}
