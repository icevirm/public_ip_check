variable "region" {
  description = "AWS region where the project is resided"
  default     = "eu-west-1"
}

variable "state_bucket_name" {
  description = "S3 bucket where state file is resided"
  default     = "icevirm"
}

# Should be filled from Jenkins job
variable "phone" {
  description = "Phone number to send SMS about check"
  default     = ""
}
