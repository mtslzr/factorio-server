resource "aws_ecs_cluster" "factorio" {
  name = "factorio"
}

resource "aws_ecs_task_definition" "factorio" {
  family                   = "factorio"

  container_definitions    = <<DEFINITION
  [
    {
      "name": "factorio",
      "image": "${aws_ecr_repository.factorio.repository_url}",
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-create-group": "true",
          "awslogs-group": "factorio",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "factorio"
        }
      },
      "mountPoints": [
        {
          "containerPath": "/factorio/saves",
          "sourceVolume": "saves"
        }
      ],
      "portMappings": [
        {
          "containerPort": 27015,
          "hostPort": 27015,
          "protocol": "tcp"
        },
        {
          "containerPort": 34197,
          "hostPort": 34197,
          "protocol": "udp"
        }
      ],
      "memory": 1024,
      "cpu": 512
    }
  ]
  DEFINITION

  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = aws_iam_role.factorio.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  volume {
    name = "saves"

    efs_volume_configuration {
      file_system_id = aws_efs_file_system.factorio.id
      root_directory = "/"
    }
  }
}

resource "aws_ecs_service" "factorio" {
  name            = "factorio"

  cluster         = aws_ecs_cluster.factorio.id
  desired_count   = 1
  force_new_deployment = true
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.factorio.arn

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.factorio-ecs.id]
    subnets          = [aws_default_subnet.default_subnet_a.id]
  }
}
