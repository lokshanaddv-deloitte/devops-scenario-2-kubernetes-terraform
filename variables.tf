
variable "aws_region" {
  description = "AWS region for Scenario 2"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type for Kubernetes"
  type        = string
  default     = "m7i-flex.large"
}

variable "instance_name" {
  description = "Name of Scenario 2 EC2 instance"
  type        = string
  default     = "Scenario-2-Kubernetes"
}

variable "root_volume_size" {
  description = "EC2 root disk size in GB"
  type        = number
  default     = 40
}


variable "admin_cidr" {
  description = "Your public IP address in CIDR format for secure access"
  type        = string
}
