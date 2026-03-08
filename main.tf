# Provider for Mumbai
provider "aws" {
  alias  = "mumbai"
  region = "ap-south-1"
}

# Provider for Virginia
provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

# Default VPC Mumbai
data "aws_vpc" "default_mumbai" {
  provider = aws.mumbai
  default  = true
}

# Default VPC Virginia
data "aws_vpc" "default_virginia" {
  provider = aws.virginia
  default  = true
}

# Security Group Mumbai
resource "aws_security_group" "nginx_sg_mumbai" {
  provider = aws.mumbai
  name     = "nginx-sg-mumbai"
  vpc_id   = data.aws_vpc.default_mumbai.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group Virginia
resource "aws_security_group" "nginx_sg_virginia" {
  provider = aws.virginia
  name     = "nginx-sg-virginia"
  vpc_id   = data.aws_vpc.default_virginia.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance Mumbai
resource "aws_instance" "nginx_mumbai" {
  provider                    = aws.mumbai
  ami                         = "ami-0f58b397bc5c1f2e8"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.nginx_sg_mumbai.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "Terraform-Nginx-Mumbai"
  }
}

# EC2 Instance Virginia
resource "aws_instance" "nginx_virginia" {
  provider                    = aws.virginia
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.nginx_sg_virginia.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "Terraform-Nginx-Virginia"
  }
}
