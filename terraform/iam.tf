resource "aws_iam_role" "factorio" {
  name               = "factorio-ecs"

  assume_role_policy = data.aws_iam_policy_document.factorio.json
}

data "aws_iam_policy_document" "factorio" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_policy" "factorio-logs" {
  name   = "factorio-logs"

  policy = data.aws_iam_policy_document.factorio-logs.json
}

data "aws_iam_policy_document" "factorio-logs" {
  statement {
    actions   = ["logs:CreateLogGroup"]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "factorio" {
  role       = aws_iam_role.factorio.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "factorio-logs" {
  role       = aws_iam_role.factorio.name
  policy_arn = aws_iam_policy.factorio-logs.arn
}
