resource "aws_instance" "example" {
  ami           = var.ami_id
  # if dev t3.micro, otherwise t3.small
  instance_type = var.environment == "dev" ? "t3.micro" : "t3.small"
  vpc_security_group_ids = [aws_security_group.allow_tls.id] # Dependent on aws_security_group creation(Dependency Management) (It is a variable already...)

  tags = var.ec2_tags
}

# Creation of security group
resource "aws_security_group" "allow_tls" {
  name        = var.sg_name # this is for AWS account  # "allow tls" is for terraform reference
  description = var.sg_description

  egress {
    from_port        = var.sg_from_port             # egress=outbound
    to_port          = var.sg_to_port
    protocol         = "-1"
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = var.sg_from_port         # ingress=inbound
    to_port          = var.sg_to_port
    protocol         = "-1"
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.sg_tags
}