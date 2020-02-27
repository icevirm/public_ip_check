resource "aws_cloudtrail" "public_ip_check_trail" {
  name                          = "public_ip_check_trail"
  s3_bucket_name                = "${aws_s3_bucket.public_ip_check_trail.id}"
  s3_key_prefix                 = "cloudtrail_logs"
  include_global_service_events = false

  depends_on = ["aws_s3_bucket_policy.public_ip_check_trail"]
}
