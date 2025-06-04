# variables.tf
variable "container_name" {
  type        = string
  description = "Name for the Nginx Docker container."
  default     = "my-flex-nginx-container"
}

variable "external_port" {
  type        = number
  description = "External port to map to the container's internal port 80."
  # Kein Default-Wert hier, damit wir gezwungen sind, ihn zu setzen.
}

variable "nginx_html_content" {
  type        = string
  description = "HTML content for the Nginx index page."
  # Mache diesen Default wirklich statisch
  default     = "<h1>Static Default Content from Terraform</h1>"
}