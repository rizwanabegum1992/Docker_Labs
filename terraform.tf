provider "aws" {
  region = "us-west-1"  # Change this to your desired region
}

resource "aws_security_group" "example" {
  name        = "example-security-group"
  description = "Example security group created by Terraform"

  // Inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to the world (not recommended in practice)
  }

  // Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
