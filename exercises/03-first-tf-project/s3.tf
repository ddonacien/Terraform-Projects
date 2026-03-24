resource "random_id" "s3_id_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "s3-bucket-${random_id.s3_id_suffix.hex}"
}

 output "bucket_name_output" {
  value = aws_s3_bucket.s3_bucket.bucket
}
