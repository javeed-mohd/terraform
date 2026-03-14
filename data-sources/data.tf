# Data sources are used to query and fetch existing information from your provider like AWS, so you can use that data in your Terraform configuration.
# For AMI-ID
data "aws_ami" "joindevops" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_instance" "terraform_instance" {
  instance_id = "i-0d7c8cb73305d9cfc"
}