resource "aws_s3_bucket" "bucket" {
  bucket = "gltest-bucket"
  acl    = "private"

  tags = {
    Name = "gltest-bucket"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = "${aws_s3_bucket.bucket.id}"
  key    = "index.html"
  source = "../index.html"
}

