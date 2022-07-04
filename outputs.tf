output "nat_instance_public_ip" {
  description = "Nat instance public IP"
  value       = var.enabled ? aws_instance.nat[0].public_ip : null
}
