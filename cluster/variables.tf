variable "name" {
  description = "Name to be used on all the resources as identifier."
  type        = string
  default     = "consul-virtual-day-ecs"
}

variable "region" {
  description = "AWS region."
  type        = string
  default     = "us-east-1"
}
