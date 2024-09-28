resource "aws_instance" "public_ec2_1" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI (check if this is free-tier eligible in your region)
  instance_type = "t2.micro"               # Free-tier instance type
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "public_ec2_1"
  }
 # Attach EC2 to the target group
  provisioner "local-exec" {
    command = "aws elbv2 register-targets --target-group-arn ${aws_lb_target_group.app_tg.arn} --targets Id=${self.id}"
  }

  # Security group allowing SSH access
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  provisioner "local-exec" {
    command = "echo ' ${self.tags.Name} ${self.public_ip}' >> all_ips.txt"
  }
   provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",          # Update the package manager
      "sudo yum install -y httpd",   # Install Apache
      "sudo systemctl start httpd",  # Start Apache
      "sudo systemctl enable httpd", # Enable Apache to start on boot
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip     # Connect using the public IP of the instance
      user        = "ec2-user"         # Default user for Amazon Linux
      private_key = file("~/.ssh/id_rsa")  # Path to your SSH private key
    }
  }
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

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
