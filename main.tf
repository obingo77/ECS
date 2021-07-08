provider "aws" {
  region = var.region
}

data "terraform_remote_state" "base" {
  backend = "local"

  config = {
    path = "../base/terraform.tfstate"
  }
}

# Run the Consul dev server as an ECS task.
module "dev_consul_server" {
  source  = "hashicorp/consul-ecs/aws//modules/dev-server"
  version = "0.1.1"

  name                        = "${var.name}-consul-server"
  ecs_cluster_arn             = data.terraform_remote_state.base.outputs.ecs_cluster_arn
  subnet_ids                  = data.terraform_remote_state.base.outputs.private_subnet_ids
  lb_vpc_id                   = data.terraform_remote_state.base.outputs.vpc_id
  lb_enabled                  = true
  lb_subnets                  = data.terraform_remote_state.base.outputs.public_subnet_ids
  lb_ingress_rule_cidr_blocks = ["${var.lb_ingress_ip}/32"]
  log_configuration = {
    logDriver = "awslogs"
    options = {
      awslogs-group         = data.terraform_remote_state.base.outputs.log_group_name
      awslogs-region        = var.region
      awslogs-stream-prefix = "consul-server"
    }
  }
  launch_type  = "FARGATE"
  consul_image = "docker.mirror.hashicorp.services/hashicorp/consul:1.10.0-rc2"
}

resource "aws_security_group_rule" "ingress_from_server_alb_to_ecs" {
  type                     = "ingress"
  from_port                = 8500
  to_port                  = 8500
  protocol                 = "tcp"
  source_security_group_id = module.dev_consul_server.lb_security_group_id
  security_group_id        = data.aws_security_group.vpc_default.id
}

data "aws_security_group" "vpc_default" {
  name   = "default"
  vpc_id = data.terraform_remote_state.base.outputs.vpc_id
}
