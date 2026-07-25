data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "s3_reader" {
  name               = "${var.project_name}-s3-reader"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {
    Name = "${var.project_name}-s3-reader"
  }
}

data "aws_iam_policy_document" "s3_read_only" {
  statement {
    sid     = "ListPrivateBucket"
    effect  = "Allow"
    actions = ["s3:ListBucket"]

    resources = [aws_s3_bucket.private.arn]
  }

  statement {
    sid     = "ReadObjectsFromPrivateBucket"
    effect  = "Allow"
    actions = ["s3:GetObject"]

    resources = ["${aws_s3_bucket.private.arn}/*"]
  }
}

resource "aws_iam_role_policy" "s3_read_only" {
  name   = "${var.project_name}-s3-read-only"
  role   = aws_iam_role.s3_reader.name
  policy = data.aws_iam_policy_document.s3_read_only.json
}

resource "aws_iam_instance_profile" "s3_reader" {
  name = "${var.project_name}-s3-reader"
  role = aws_iam_role.s3_reader.name
}
