
resource "aws_vpc" "scenario2_vpc" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Scenario-2-VPC"
  }
}

resource "aws_subnet" "scenario2_subnet" {
  vpc_id                  = aws_vpc.scenario2_vpc.id
  cidr_block              = "10.20.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Scenario-2-Public-Subnet"
  }
}

resource "aws_internet_gateway" "scenario2_igw" {
  vpc_id = aws_vpc.scenario2_vpc.id

  tags = {
    Name = "Scenario-2-Internet-Gateway"
  }
}

resource "aws_route_table" "scenario2_route_table" {
  vpc_id = aws_vpc.scenario2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.scenario2_igw.id
  }

  tags = {
    Name = "Scenario-2-Route-Table"
  }
}

resource "aws_route_table_association" "scenario2_route_association" {
  subnet_id      = aws_subnet.scenario2_subnet.id
  route_table_id = aws_route_table.scenario2_route_table.id
}

resource "aws_security_group" "scenario2_sg" {
  name        = "scenario-2-kubernetes-sg"
  description = "Security group for Scenario 2 Kubernetes EC2"
  vpc_id      = aws_vpc.scenario2_vpc.id

  # SSH from your current public IP
  ingress {
    description = "SSH from personal IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  # SSH from AWS EC2 Instance Connect
  ingress {
    description     = "AWS EC2 Instance Connect"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    prefix_list_ids = ["pl-0fa83cebf909345ca"]
  }

  # Kubernetes API server
  ingress {
    description = "Kubernetes API server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  # Online Boutique NodePort
  ingress {
    description = "Online Boutique NodePort"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  # Internal cluster communication
  ingress {
    description = "Internal cluster communication"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Scenario-2-Security-Group"
  }
}

resource "aws_instance" "scenario2_kubernetes" {
  ami                         = "ami-032eca770b5d15e72"
  instance_type               = var.instance_type
  key_name                    = "online-boutique-key"
  subnet_id                   = aws_subnet.scenario2_subnet.id
  vpc_security_group_ids      = [aws_security_group.scenario2_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
  }

  tags = {
    Name = var.instance_name
  }
}

