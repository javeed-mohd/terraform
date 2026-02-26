variable "ingress_rules" {
  default   = [
    {
        port            = 22 # Secure Shell(SSH)
        cidr_blocks     = ["0.0.0.0/0"]
        description     = "Allowing port number 22 from the internet"
    },
    {
        port            = 443 # HTTPS
        cidr_blocks     = ["0.0.0.0/0"]
        description     = "Allowing port number 443 from the internet"
    },
    {
        port            = 3306 # MySQL
        cidr_blocks     = ["0.0.0.0/0"]
        description     = "Allowing port number 3306 from the internet"
    }
  ] 
}