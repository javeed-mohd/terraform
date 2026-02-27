resource "aws_route53_record" "www" {
  for_each = aws_instance.example
  zone_id  = var.zone_id
  # Interpolation is inserting dynamic values (variables, resource attributes, functions) into strings.
  name     = "${each.key}.${var.domain_name}" # mongodb.devopsdaws.online
  type     = "A"
  ttl      = 1
  records  = [each.value.private_ip]
  allow_overwrite = true
}

# roboshop.devopsdaws.online => public_ip
# It is for functions
resource "aws_route53_record" "www" {
  zone_id  = var.zone_id
  # Interpolation is inserting dynamic values (variables, resource attributes, functions) into strings.
  name     = "roboshop.${var.domain_name}" # roboshop.devopsdaws.online
  type     = "A"
  ttl      = 1
  records  = [lookup(aws_instance.example, "frontend").public_ip] # lookup(map, key) ==> Returns value
  allow_overwrite = true
}