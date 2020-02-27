resource "aws_lambda_function" "public_ip_check" {
  filename      = "user_data/public_ip_check.zip"
  function_name = "public_ip_check"
  role          = "${aws_iam_role.lambda_access.arn}"
  handler       = "public_ip_check.lambda_handler"

  runtime = "python3.8"

  environment {
    variables = {
      instanceId = "${aws_instance.no_public_ip_instance.id}"
      eniId      = "${aws_instance.no_public_ip_instance.primary_network_interface_id}"
      topic_arn  = "${aws_sns_topic.public_ip_check.arn}"
    }
  }
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.public_ip_check.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.public_ip_check.arn}"
}
