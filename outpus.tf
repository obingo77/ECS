    
output "consul_server_lb_address" {
  value = "http://${module.dev_consul_server.lb_dns_name}:8500"
}

output "consul_server_service_name" {
  value = module.dev_consul_server.ecs_service_name
}
