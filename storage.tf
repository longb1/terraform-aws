#s3 bucket
resource "aws_s3_bucket" "longb_s3" {
  bucket = "longb_s3"
  acl    = "private"

  tags = {
    Name        = "longb_s3"
    Environment = "Dev"
  }
}