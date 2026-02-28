# To record we use local and to store we use locals...

resource "aws_instance" "example" {
  ami           = local.ami_id
  instance_type = local.instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id] # Dependent on aws_security_group creation(Dependency Management)

  /* tags = {
    Name = local.instance_name # 1. To access locals.tf, we use this...
    Project = "roboshop"
  } */
  tags  = local.ec2_final_tags
}

# Creation of security group
resource "aws_security_group" "allow_tls" {
  name        = "allow-all-terraform" # this is for AWS account  # "allow tls" is for terraform reference
  description = "Allow TLS inbound traffic and all outbound traffic"

  egress {
    from_port        = 0 # egress=outbound
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 0 # ingress=inbound
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-all-terraform"
  }
}