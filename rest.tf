provider "aws" {
  region = "us-west-1"  # Change this to your desired region
}

resource "aws_security_group" "open_to_internet" {
  name_prefix = "OpenToInternet-"
  description = "Example security group allowing open internet access"
}

resource "aws_security_group_rule" "open_ingress" {
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.open_to_internet.id
}

resource "aws_s3_bucket" "public_read_bucket" {
  bucket = "public-read-bucket-example"
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.public_read_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "disable_logging" {
  bucket = aws_s3_bucket.public_read_bucket.id
  logging_enabled = false
}

output "security_group_id" {
  value = aws_security_group.open_to_internet.id
}

output "s3_bucket_name" {
  value = aws_s3_bucket.public_read_bucket.id
}
