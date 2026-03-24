# Reverse process with infra, we create resource....
resource "aws_instance" "import" {
    instance_type           = "t3.micro"
    ami                     = "ami-0220d79f3f480ecf5"
    vpc_security_group_ids  = [
        "sg-0bdbfe5495a912910"
    ]
    subnet_id               = "subnet-0388641d42d74eb47"
    tags = {
        Name = "import-demo-change"
    }
}