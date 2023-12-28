provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket_policy" "example_bucket_policy" {
  bucket = "example-bucket"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${aws_iam_role.example_role.name}"
        },
        "Action": [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        "Resource": [
          "arn:aws:s3:::example-bucket",
          "arn:aws:s3:::example-bucket/*"
        ]
      }
    ]
  })
}

data "aws_caller_identity" "current" {}
