# outputs you can kist required endpoints, ip or instanceid's

# output "alb_hostname" {
#   value = aws_alb.alb.dns_name
# }


output "public_ip" {
  value = aws_ecs_task_definition.task-def.container_definitions
}
