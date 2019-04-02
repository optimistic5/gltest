resource "aws_s3_bucket" "backet" {
  bucket = "gltest-bucket"
  acl    = "private"

  tags = {
    Name = "gltest-bucket"
  }
}

