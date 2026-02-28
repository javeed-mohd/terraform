resource "aws_instance" "example" {
  ami           = "ami-0220d79f3f480ecf5"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id] # Dependent on aws_security_group creation(Dependency Management)

  tags = {
    Name = "terraform"
    Project = "roboshop"
  }
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

  # Here ingress is going to be special variable (Ingress = inbound)
  dynamic "ingress" {
    for_each = toset(var.ingress_rules) # It accepts with or without toset same result, but in for_each loop it has to be separate for list and set for resource creation...
    content {
        from_port        = ingress.value.port
        to_port          = ingress.value.port
        protocol         = "tcp"
        cidr_blocks      = ingress.value.cidr_blocks
        description      = ingress.value.description
    }
  }

  tags = {
    Name = "allow-all-terraform"
  }
}