# Create a security group for the load balancer
resource "aws_security_group" "lb_sg" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "load-balancer-sg"
  }
}

# Create the Load Balancer
resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tags = {
    Name = "app-lb"
  }
}

# Create a target group
resource "aws_lb_target_group" "app_tg" {
  name     = "app-targets"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  health_check {
    protocol = "HTTP"
    path     = "/"
    interval = 30
    timeout  = 5
  }

  tags = {
    Name = "app-target-group"
  }
}

# Create listener for the load balancer
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}


    