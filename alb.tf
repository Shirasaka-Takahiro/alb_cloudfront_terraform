##ALB
resource "aws_lb" "alb" {
  name               = "${var.general_config["project"]}-${var.general_config["env"]}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids
  ip_address_type    = "ipv4"

  access_logs {
    bucket  = aws_s3_bucket.bucket_alb_access_log.id
    prefix  = var.general_config["project"]
    enabled = true
  }

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-alb"
  }
}

##Target Group
resource "aws_lb_target_group" "tg" {
  name             = "${var.general_config["project"]}-${var.general_config["env"]}-tg"
  target_type      = "instance"
  protocol_version = "HTTP1"
  port             = "80"
  protocol         = "HTTP"
  vpc_id           = aws_vpc.vpc.id

  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 5
    matcher             = "200"
  }

  tags = {
    Name = "${var.general_config["project"]}-${var.general_config["env"]}-tg"
  }
}

##HTTP Listener
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

##HTTPS Listener
resource "aws_alb_listener" "alb_https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert_alb.arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Access Denied"
      status_code  = "503"
    }
  }

}

##HTTPS Listener Rule
resource "aws_lb_listener_rule" "https_header" {
  listener_arn = aws_alb_listener.alb_https.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

  condition {
    http_header {
      http_header_name = "shira-test"
      values           = ["shira-test"]
    }
  }

}

##Attach target group to the alb
resource "aws_lb_target_group_attachment" "tg-to-ec2" {
  count            = length(var.instance_ids)
  target_id        = element(var.instance_ids, count.index % 2)
  target_group_arn = aws_lb_target_group.tg.arn
  port             = 80
}