/*
provider "consul" {
  address = data.terraform_remote_state.consul.outputs.consul_server_lb_address
  datacenter = "dc1"
}
resource "consul_config_entry" "service_defaults_server" {
  kind = "service-defaults"
  name = "${var.name}-example-server-app"
  config_json = jsonencode({
    Protocol = "http"
  })
}
resource "consul_config_entry" "service_defaults_client" {
  kind = "service-defaults"
  name = "${var.name}-example-client-app"
  config_json = jsonencode({
    Protocol = "http"
  })
}
resource "consul_config_entry" "service_router_server" {
  kind = "service-router"
  name = "${var.name}-example-server-app"
  config_json = jsonencode({
    Routes = [
      {
        Destination = {
          NumRetries = 3
          RetryOnStatusCodes = [500]
        }
      }
    ]
  })
}
*/
