data "aws_iam_policy_document" "iam_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:*",
    ]

    resources = [
      aws_s3_bucket.terraform-bucket.arn,
      "${aws_s3_bucket.terraform-bucket.arn}/*",
    ]
  }
}
