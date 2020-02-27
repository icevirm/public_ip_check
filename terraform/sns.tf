resource "aws_sns_topic" "public_ip_check" {
  name = "public_ip_check"
}

resource "aws_sns_topic_subscription" "public_ip_check" {
  topic_arn = "${aws_sns_topic.public_ip_check.arn}"
  protocol  = "sms"
  endpoint  = "${var.phone}"
}
