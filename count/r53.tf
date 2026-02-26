resource "aws_route53_record" "www" {
  count = 10
  zone_id = var.zone_id
  # Interpolation is inserting dynamic values (variables, resource attributes, functions) into strings.
  name    = "${var.instances[count.index]}.${var.domain_name}" # mongodb.devopsdaws.online
  type    = "A"
  ttl     = 1
  records = [aws_instance.example[count.index].private_ip]
}