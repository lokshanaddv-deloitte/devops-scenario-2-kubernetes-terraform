output "instance_id" {
  description = "Scenario 2 EC2 instance ID"
  value       = aws_instance.scenario2_kubernetes.id
}

output "public_ip" {
  description = "Scenario 2 EC2 public IP"
  value       = aws_instance.scenario2_kubernetes.public_ip
}

output "public_dns" {
  description = "Scenario 2 EC2 public DNS"
  value       = aws_instance.scenario2_kubernetes.public_dns
}
