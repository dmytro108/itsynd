# Create a target group for the application load balancer
resource "aws_lb_target_group" "app_target_group" {
  name     = "app-target-group"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  target_type = "ip"
  preserve_client_ip = false
  health_check {
    interval = 30
    path     = "/"
    port     = "traffic-port"
    protocol = "HTTP"
    timeout  = 5
  }
}

# Create a listener for the application load balancer
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.app_target_group.arn
    type             = "forward"
  }
}

# Create an application load balancer
resource "aws_lb" "alb" {
  name               = "app-lb"
  load_balancer_type = "application"
  subnets            = local.public_subnets
  security_groups    = [module.sg_alb.security_group_id]

  enable_deletion_protection = false
}
