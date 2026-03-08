# Terraform Multi-Region EC2 Deployment with Nginx

## Project Overview

This project demonstrates Infrastructure as Code (IaC) using Terraform to deploy EC2 instances in two different AWS regions and automatically install Nginx.

## Architecture

Terraform → AWS EC2 → Nginx Web Server

Two EC2 instances are created in different regions:

- ap-south-1 (Mumbai)
- us-east-1 (Virginia)

Nginx is installed automatically using Terraform user_data script.

## Technologies Used

- Terraform
- AWS EC2
- AWS CLI
- GitHub

## Deployment Steps

Initialize Terraform

terraform init

Validate Terraform configuration

terraform validate

Preview infrastructure changes

terraform plan

Create infrastructure

terraform apply

Destroy infrastructure (to avoid AWS charges)

terraform destroy

## Result

Two EC2 instances were successfully deployed in different AWS regions with Nginx installed and accessible via public IP.

## Screenshots

All screenshots of Terraform execution and AWS resources are available in the screenshots folder.
