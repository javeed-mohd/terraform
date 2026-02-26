# Output for ec2_instances
output "roboshop-instances" {
  value       = aws_instance.example
  description = "description"
}

output "fruits_names" {
  value        = var.fruits # Here, List allows duplicate values (Ordered, index based values[0],[1]....)
}

output "fruits_set" {
  value        = var.fruits_set # Here, Set removes duplicate values (Order not guaranteed)
}