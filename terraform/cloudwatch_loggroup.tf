# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "testapp_log_group" {
  name              = "${var.app_name}-awslogs"
  retention_in_days = 3


  tags = {
    Name = "cw-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "myapp_log_stream" {
  name           = "${var.app_name}-awslogs-stream"
  log_group_name = aws_cloudwatch_log_group.testapp_log_group.name
}
