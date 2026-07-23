resource "aws_s3_bucket" "main" {
  bucket_prefix = "${var.project_name}-"

  tags = {
    Name = "${var.project_name}-bucket"
  }
}
