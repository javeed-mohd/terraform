resource "aws_instance" "example" {
  ami           = "ami-0220d79f3f480ecf5"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id] # Dependent on aws_security_group creation(Dependency Management)

# Self is the special variable, self refers to the current resource.
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > inventory.ini"
  }

  provisioner "local-exec" {
    command = "exit 1"
    on_failure = continue
  }

  provisioner "local-exec" {
    command = "echo script-2"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Deleting the instance'"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo > inventory.ini" # To empty the inventory.ini because ansible tries to connect it....
  }

  # Connection block is mandatory to have the ssh protocol access to connect in remote exec....
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }

  # Inline command means it executes the scripts line by line
  provisioner "remote-exec" {
    inline = [
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx"
    ]
  }

  # Here, first it stops the nginx server and then destroys the instance/sg_id....
  provisioner "remote-exec" {
    inline = [
      "sudo systemctl stop nginx"
    ]
    when   = destroy
  }

  tags = {
    Name = "provisioners-demo"
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