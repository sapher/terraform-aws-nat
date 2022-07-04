output "nat_instance_public_ip" {
  description = "Nat instance public IP"
  value       = aws_instance.nat.public_ip
}