resource "aws_s3_bucket" "main" {
  bucket_prefix = "${var.project_name}-"

  tags = {
    Name = "${var.project_name}-bucket"
  }
}

# New S3 buckets are private by default, but good practice to add it
# -> this allows Terraform to detect/restore changes for any of these settings
resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "test_file" {
  bucket       = aws_s3_bucket.main.id
  key          = "test-file.txt"
  content      = "Hello from the private S3 bucket."
  content_type = "text/plain"
}