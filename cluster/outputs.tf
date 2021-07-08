output "ecs_cluster_arn" {
  value = aws_ecs_cluster.this.arn
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "log_group_name" {
  description = "Name of CloudWatch log group."
  value       = aws_cloudwatch_log_group.log_group.name
}
