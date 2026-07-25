resource "aws_instance" "private" {
  ami           = local.amazon_linux_2023_ami
  instance_type = local.instance_type

  subnet_id                   = aws_subnet.private.id
  associate_public_ip_address = false

  # t3 instances are "unlimited" by default, but no need to have it in such basic project
  credit_specification {
    cpu_credits = "standard"
  }

  vpc_security_group_ids = [aws_security_group.ec2.id]

  iam_instance_profile = aws_iam_instance_profile.s3_reader.name

  tags = {
    Name = "${var.project_name}-ec2"
  }
}
