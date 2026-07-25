resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private.id
  ]

  tags = {
    Name = "${var.project_name}-s3-gateway-endpoint"
  }
}

resource "aws_ec2_instance_connect_endpoint" "private" {
  subnet_id          = aws_subnet.private.id
  security_group_ids = [aws_security_group.eice.id]

  tags = {
    Name = "${var.project_name}-eice"
  }
}
