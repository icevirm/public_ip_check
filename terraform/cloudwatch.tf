resource "aws_cloudwatch_event_rule" "public_ip_check" {
  name        = "public_ip_check_events"
  description = "Capture changes in EC2 via CloudTrail"

  event_pattern = <<PATTERN
{
    "source": [
    "aws.ec2"
  ],
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "detail": {
    "eventSource": [
      "ec2.amazonaws.com"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "public_ip_check_parser" {
  rule = "${aws_cloudwatch_event_rule.public_ip_check.name}"
  arn  = "${aws_lambda_function.public_ip_check.arn}"

  input_path = "$.detail"
}
