# Scenario 2 – Online Boutique on AWS using Terraform and Kubernetes

## Project Overview
This project deploys the Google Online Boutique microservices application on a self-managed Kubernetes cluster hosted on AWS EC2.

## Architecture
- AWS VPC
- Public subnet
- Internet Gateway
- Route table
- Security Group
- Ubuntu EC2 instance
- Terraform for infrastructure provisioning
- containerd as the container runtime
- kubeadm, kubelet and kubectl
- Calico networking
- Online Boutique microservices

## Kubernetes
- Kubernetes: v1.37.2
- Calico: v3.33.1
- Application: Google Online Boutique
- Microservices: 12
- Deployment: Single-node Kubernetes cluster

## Application Access
Frontend NodePort:
http://65.1.111.198:32558

Note: The application URL works while the EC2 instance is running. The public IP may change after stopping and restarting the instance.

## Terraform Files
- main.tf
- provider.tf
- variables.tf
- outputs.tf

## Security
Terraform state files, private keys and environment files are excluded from Git using .gitignore.
