resource "aws_s3_bucket" "public_ip_check_trail" {
  bucket        = "public-ip-check-trail"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "public_ip_check_trail" {
  bucket = "${aws_s3_bucket.public_ip_check_trail.id}"

  policy = "${data.aws_iam_policy_document.public_ip_check_trail.json}"
}
