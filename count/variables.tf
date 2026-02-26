# Variable for ec2_instance
variable "instances" {
  type        = list
  default     = ["mongodb", "catalogue", "redis", "user", "cart", "mysql", "shipping", "rabbitmq", "payment", "frontend"]
}

# Variable for R53 records (Zone_id and domain_name)
variable "zone_id" {
  default      = "Z0883755364LI3FEBC65Q" 
}

variable "domain_name" {
  default      = "devopsdaws.online"
}

# Difference btw list(count based loop) and set/map(for_each loop)
variable "fruits" {
  type         = list(string)
  default      = ["apple", "banana", "cherry", "apple", "dragon"]
}

variable "fruits_set" {
  type         = set(string)
  default      = ["apple", "banana", "cherry", "apple", "dragon"]
}