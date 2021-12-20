#s3 bucket
resource "aws_s3_bucket" "longb_s3" {
  bucket = "longbstorage"
  acl    = "private"

  tags = {
    Name        = "longbstorage"
    Environment = "Dev"
  }
}