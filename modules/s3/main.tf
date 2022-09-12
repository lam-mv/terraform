resource "aws_s3_bucket" "terraform-bucket" {
  bucket = "lam.mv-test"
  tags = {
    Name = var.s3_name
  }
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.terraform-bucket.id
  policy = data.aws_iam_policy_document.iam_policy.json
}

resource "aws_s3_bucket_website_configuration" "web-config" {
  bucket = aws_s3_bucket.terraform-bucket.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "object" {
  for_each     = fileset(path.module, "static-web/**/*")
  bucket       = aws_s3_bucket.terraform-bucket.id
  key          = replace(each.value, "static-web", "")
  source       = each.value
  etag         = filemd5("${each.value}")
  content_type = lookup(local.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.terraform-bucket.id
  acl = "public-read"
}
