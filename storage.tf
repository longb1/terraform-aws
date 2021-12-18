#s3 bucket
resource "aws_s3_bucket" "longb_s3" {
  bucket = "s3-bucket-terrafrom"
  acl    = "private"

  tags = {
    Name        = "longb_s3"
    Environment = "Dev"
  }
}