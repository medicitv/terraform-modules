
resource "aws_iam_role" "ecs_execution_role" {
    
    name = "${var.execution_role_name}"

    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


resource "aws_iam_role" "ecs_task_role" {
    
    name = "${var.execution_role_name}-task"

    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
    role = "${aws_iam_role.ecs_execution_role.id}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_get_secrets" {
  role       = aws_iam_role.ecs_execution_role.id
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

data "aws_iam_policy_document" "app_task" {
  statement {
    sid     = "EnableCommandExecution"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = ["*"]
  }

    statement {
      sid  = "ECRAccess"
      actions = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage"
      ]
      resources = ["*"]
    }
}

resource "aws_iam_role_policy" "app_task" {
  role   = "${aws_iam_role.ecs_task_role.id}"
  policy = data.aws_iam_policy_document.app_task.json
}

resource "aws_cloudwatch_log_group" "ecs_cloudwatch_log_group" {
    name = var.ecs_cloudwatch_log_group_name

    tags = merge(
        var.TAGS,
        {
            "Name" = var.ecs_cloudwatch_log_group_name
        },
    )
 
}

module "container_definition" {
  source = "github.com/cloudposse/terraform-aws-ecs-container-definition?ref=0.38.0"
  container_name = var.container_name
  container_image = var.container_image
  container_cpu = var.cpu
  container_memory = var.memory
  essential = "true"
  environment = var.environment
  secrets = var.secrets
  log_configuration = {
                        logDriver = "awslogs"
                        options = {
                        "awslogs-group"         = aws_cloudwatch_log_group.ecs_cloudwatch_log_group.name
                        "awslogs-region"        = var.region
                        "awslogs-stream-prefix" = var.log_stream_prefix
                        }
                    }
}

resource "aws_ecs_task_definition" "task_definition" {
    family = var.name

    network_mode = "awsvpc"
    container_definitions = "[${module.container_definition.json_map_encoded}]"

    requires_compatibilities = [ "FARGATE" ]
    cpu = var.cpu
    memory = var.memory
    execution_role_arn = "${aws_iam_role.ecs_execution_role.arn}"
    task_role_arn = "${aws_iam_role.ecs_task_role.arn}"

    tags = merge(
        var.TAGS,
        {
            "Name" = var.name
        },
    )

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_ecs_service" "service" {
    name = var.name
    cluster  = var.cluster_id

    task_definition = aws_ecs_task_definition.task_definition.arn
    launch_type = "FARGATE"
    desired_count = var.desired_count
    enable_execute_command = true
    network_configuration {
        subnets         = var.subnets
        security_groups = var.security_groups
    }

    lifecycle {
        create_before_destroy = true
    }
}