resource "aws_ecs_cluster" "cluster" {
  name = "${var.app_name}-cluster"
}

data "template_file" "template" {
  template = file("./templates/image/superclassicos-container-definitions.json")

  vars = {
    app_name         = var.app_name
    app_image        = var.app_image
    app_port         = var.app_port
    container_port   = var.container_port
    fargate_cpu      = var.fargate_cpu
    fargate_memory   = var.fargate_memory
    aws_region       = var.aws_region
    cloudwatch_group = var.cloudwatch_group
  }
}

resource "aws_ecs_task_definition" "task-def" {
  family                   = "${var.app_name}-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.template.rendered
}

resource "aws_ecs_service" "service" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task-def.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = aws_subnet.public.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.lb-tg.arn
    container_name   = var.app_name
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.alb-listener, aws_iam_role_policy_attachment.ecs_task_execution_role]
}
