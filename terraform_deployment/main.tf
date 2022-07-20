terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.22"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web_server" {
  ami           = "ami-02f3416038bdb17fb"
  instance_type = "t2.micro"
  key_name = "mykey"
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "Test VM"
  }
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 80
  }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCs/fN4qE0N81tRD7X1FpbF2toePg+1HahxZ3hSquvMHAE69Z16dJgQPmXBaY19VgPw1alfirQmWGmVoRFuYoLI/FvGXz/7+AkPsYXnmBVWE/MYx0g4OzwU7gcxjdxUYfbnPlU2hPNBb115nhVZiDfTwSZW447u/XTkUcLs+viOhlRkfucTDY+pfoOtto/VqpjcOBP4IerXL7g6YKBApGy1oyawkxxNSn7ALw7wWnsxs+BA8B7lOLmqfW3nbUsPuAy7IbRWMg5E66FXA5wvUGssw2Hqy5VXbJkh/RZpjNO7AwMhQx9OEWlfIYupFvVFJYh2nohoE8K+Z5YGZUrNcQIezo346PUM3BPY8ptWq/7q8CVb2tR7SExB3N0EDV2+CFDdXvvZutxYSLhZiaChpSHVW9uLWy+Rqwl2s9/sjzVgqpmQ6UsmHduUnTlMqAhYWTYx0bouBE5iLAoSIQzWhW9PTRCgVEpgo9EHDIVwoD1OYqIXBjWzhab9YWZddsB3kO8="
}



