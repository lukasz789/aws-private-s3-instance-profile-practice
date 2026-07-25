output "ec2_instance_id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.private.id
}

output "s3_bucket_name" {
  description = "Globally unique name generated for the S3 bucket."
  value       = aws_s3_bucket.private.id
}