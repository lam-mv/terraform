provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "terraform-bucket" {
  bucket = "terraform-series-bucket"
  policy = file("s3_static_policy.json")
  tags = {
    Name        = "Terraform s3"
  }
}
