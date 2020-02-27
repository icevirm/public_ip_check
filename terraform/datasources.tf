data "aws_caller_identity" "current" {}

data "aws_ami" "amazon2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_iam_policy_document" "assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "public_ip_check" {
  statement {
    effect = "Allow"

    actions = ["ec2:Describe*"]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = ["logs:CreateLogGroup"]

    resources = ["arn:aws:logs::*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:::log-group:/aws/lambda/public_ip_check:*"]
  }

  statement {
    effect = "Allow"

    actions = ["sns:Publish"]

    resources = ["${aws_sns_topic.public_ip_check.arn}"]
  }
}

data "aws_iam_policy_document" "public_ip_check_trail" {
  statement {
    principals {
      identifiers = ["cloudtrail.amazonaws.com"]
      type        = "Service"
    }

    effect = "Allow"

    actions = ["s3:GetBucketAcl"]

    resources = ["${aws_s3_bucket.public_ip_check_trail.arn}"]
  }

  statement {
    principals {
      identifiers = ["cloudtrail.amazonaws.com"]
      type        = "Service"
    }

    effect = "Allow"

    actions = ["s3:PutObject"]

    resources = ["${aws_s3_bucket.public_ip_check_trail.arn}/cloudtrail_logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = ["bucket-owner-full-control"]
    }
  }
}
