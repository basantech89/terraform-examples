resource "aws_s3_bucket" "bs" {
  bucket = "bs-example-bkt"

  tags = {
    Environment = "production"
    CreatedBy   = "terraform"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}


resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.bs.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.bs.id
  acl    = "private"

  depends_on = [aws_s3_bucket_ownership_controls.example]
}
