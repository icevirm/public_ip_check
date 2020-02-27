resource "aws_iam_policy" "lambda_access" {
  name_prefix = "${format("%s-", "public_ip_check")}"
  policy      = "${data.aws_iam_policy_document.public_ip_check.json}"
  path        = "/"
}

resource "aws_iam_role" "lambda_access" {
  name_prefix        = "${format("%s-", "public_ip_check")}"
  assume_role_policy = "${data.aws_iam_policy_document.assume.json}"
}

resource "aws_iam_role_policy_attachment" "lambda_access" {
  policy_arn = "${aws_iam_policy.lambda_access.arn}"
  role       = "${aws_iam_role.lambda_access.id}"
}
