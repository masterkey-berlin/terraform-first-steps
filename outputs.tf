# outputs.tf
output "container_name_output" {
  description = "The name of the created Docker container."
  value       = docker_container.simple_nginx_container.name
}

output "container_external_port" {
  description = "The external port mapped to the container."
  value       = docker_container.simple_nginx_container.ports[0].external # Zugriff auf den ersten Port-Block
}

output "html_content_used" {
  description = "The HTML content that was injected into the container."
  value       = var.nginx_html_content
}