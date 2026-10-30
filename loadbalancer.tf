resource "aws_lb" "morays_ha_lb" {
    name               = "morays-ha-lb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.morays_app_ha_sg.id]
    subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "morays_ha_tg" {
    name     = "morays-ha-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
    health_check {
        path                = "/"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
    }
}

resource "aws_lb_listener" "morays_ha_listener" {
    load_balancer_arn = aws_lb.morays_ha_lb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.morays_ha_tg.arn
    }
}