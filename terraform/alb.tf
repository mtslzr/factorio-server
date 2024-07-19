resource "aws_alb" "factorio" {
  name               = "factorio"

  load_balancer_type = "network"
  security_groups = [aws_security_group.factorio-alb.id]
  subnets = [aws_default_subnet.default_subnet_a.id]
}

resource "aws_lb_target_group" "factorio" {
  name        = "factorio"

  port        = 34197
  protocol    = "TCP_UDP"
  target_type = "ip"
  vpc_id      = aws_default_vpc.default_vpc.id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.factorio.arn
  port              = "34197"
  protocol          = "TCP_UDP"

  default_action {
    target_group_arn = aws_lb_target_group.factorio.arn
    type             = "forward"
  }
}
