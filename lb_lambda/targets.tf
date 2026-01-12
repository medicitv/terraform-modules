// Targets and listeners
<<<<<<< HEAD
resource "aws_lb_target_group" "rest_service" {
  name        = var.name_alt == "" ? "lbt-${var.name}" : "lbt-${var.name_alt}"
=======
resource "aws_lb_target_group" "service" {
  name        = "lbt-da-${var.name}"
>>>>>>> ef0abcf (add lb_lambda)
  target_type = "lambda"

  tags = merge(
    var.TAGS,
    {
<<<<<<< HEAD
      "Name" = var.name_alt == "" ? "lbt-${var.name}" : "lbt-${var.name_alt}"
=======
      "Name" = "lbt-da-${var.name}"
>>>>>>> ef0abcf (add lb_lambda)
    },
  )
}

<<<<<<< HEAD
resource "aws_lambda_permission" "rest_service" {
=======
resource "aws_lambda_permission" "service" {
>>>>>>> ef0abcf (add lb_lambda)
  statement_id  = "AllowExecutionFromLoadBalancer"
  action        = "lambda:InvokeFunction"
  function_name = module.lb_lambda.lambda_function_name
  principal     = "elasticloadbalancing.amazonaws.com"
<<<<<<< HEAD
  source_arn    = aws_lb_target_group.rest_service.arn
}

resource "aws_lb_target_group_attachment" "rest_service" {
  target_group_arn = aws_lb_target_group.rest_service.arn
  target_id        = module.lb_lambda.lambda_function_arn

  depends_on = [aws_lambda_permission.rest_service]
}

// Listener rule
resource "aws_lb_listener_rule" "rest_service_alt" {
=======
  source_arn    = aws_lb_target_group.service.arn
}

resource "aws_lb_target_group_attachment" "service" {
  target_group_arn = aws_lb_target_group.service.arn
  target_id        = module.lb_lambda.lambda_function_arn

  depends_on = [aws_lambda_permission.service]
}

// Listener rule
resource "aws_lb_listener_rule" "service_alt" {
>>>>>>> ef0abcf (add lb_lambda)
  listener_arn = var.lb_listener_arn
  priority     = var.lb_listener_priority
  condition {
    path_pattern {
      values = var.lb_listener_path_pattern
    }
  }
  condition {
    host_header {
      values = var.lb_listener_host_header
    }
  }
  action {
    type             = "forward"
<<<<<<< HEAD
    target_group_arn = aws_lb_target_group.rest_service.arn
=======
    target_group_arn = aws_lb_target_group.service.arn
>>>>>>> ef0abcf (add lb_lambda)
  }
}