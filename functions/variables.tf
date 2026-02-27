variable "common_tags" {
    default = {
        Project     = "roboshop"
        Environment = "dev"
        Terraform   = "true"
    }
}

variable "ec2_tags" {
    default = {
        Name        = "functions-demo"
        Environment = "prod" # It overrides the previous environment key from common_tags
    }
}

variable "sg_tags" {
    default = {
        Name        = "functions-demo"
    }
}