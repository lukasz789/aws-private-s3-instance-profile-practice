output "ec2_instance_id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.private.id
}

output "aws_region" {
  description = "AWS region where the resources are deployed."
  value       = var.region
}
