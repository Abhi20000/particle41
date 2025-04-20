variable "vpc_id" {}
variable "private_subnets" {
  type = list(string)
}
variable "target_group_arn" {}
variable "ecs_task_exec_role_arn" {}
variable "alb_security_group_id" {}  # <- New variable
