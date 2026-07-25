# ------------------------------------------------------------------------------
# EC2 security group and rules
# ------------------------------------------------------------------------------
resource "aws_security_group" "ec2" {
  name        = "${var.project_name}-ec2-sg"
  description = "SSH access only from the EC2 Instance Connect Endpoint"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-ec2-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2_ssh_from_eice" {
  security_group_id            = aws_security_group.ec2.id
  referenced_security_group_id = aws_security_group.eice.id
  description                  = "SSH from the EC2 Instance Connect Endpoint"

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "ec2_https_to_s3" {
  security_group_id = aws_security_group.ec2.id
  description       = "HTTPS from EC2 to S3 through the Gateway Endpoint"

  prefix_list_id = aws_vpc_endpoint.s3.prefix_list_id
  ip_protocol    = "tcp"
  from_port      = 443
  to_port        = 443
}

# ------------------------------------------------------------------------------
# EC2 Instance Connect Endpoint security group and rules
# ------------------------------------------------------------------------------
resource "aws_security_group" "eice" {
  name        = "${var.project_name}-eice-sg"
  description = "Outbound SSH access to the private EC2 instance"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-eice-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "eice_ssh_to_ec2" {
  security_group_id            = aws_security_group.eice.id
  referenced_security_group_id = aws_security_group.ec2.id
  description                  = "SSH to the private EC2 instance"

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}
