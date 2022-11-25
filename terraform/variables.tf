variable "app_name" {
  default = "superclassicos"
}

variable "aws_access_key" {
  type        = string
  description = "AWS Access key"
}
variable "aws_secret_key" {
  type        = string
  description = "AWS Secret key"
}
variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "az_count" {
  default     = "2"
  description = "number of availability zones in above region"
}

variable "ecs_task_execution_role" {
  default     = "myECcsTaskExecutionRole"
  description = "ECS task execution role name"
}

variable "task_role" {
  description = "Name of the task role."
  type        = string
  default     = "superclassicos-task-role"
}

variable "app_image" {
  default     = "395296775531.dkr.ecr.us-east-1.amazonaws.com/superclassicos:ec2v4"
  description = "docker image to run in this ECS cluster"
}

variable "app_port" {
  default     = "3000"
  description = "portexposed on the docker image"
}

variable "container_port" {
  default     = "3000"
  description = "portexposed on the docker image"
}

variable "app_count" {
  default     = "1" #choose 2 bcz i have choosen 2 AZ
  description = "numer of docker containers to run"
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  default     = "1024"
  description = "fargate instacne CPU units to provision,my requirent 1 vcpu so gave 1024"
}

variable "fargate_memory" {
  default     = "2048"
  description = "Fargate instance memory to provision (in MiB) not MB"
}

variable "cloudwatch_group" {
  description = "CloudWatch group name."
  type        = string
  default     = "superclassicos-task-group"
}
