# main.tf

# Die docker_image Ressource wurde ja gelöscht, falls du das schon gemacht hast.
# Falls nicht, hier wäre sie vorher gewesen.

resource "docker_container" "simple_nginx_container" {
  name  = var.container_name       # Nutzt die Variable
  image = "nginx:latest"           # Image direkt hier angeben

  ports {
    internal = 80
    external = var.external_port   # Nutzt die Variable
  }

provisioner "local-exec" {
  interpreter = ["bash", "-c"]
  command     = "docker exec ${self.name} sh -c 'echo \"${var.nginx_html_content}\" > /usr/share/nginx/html/index.html'"
}
    # Optional: Bessere Fehlerbehandlung oder Ausführungsumgebung für den Provisioner
    # interpreter = ["bash", "-c"] # Kann manchmal helfen, je nach Komplexität des Befehls
    # environment = {
    #   MY_VAR = "some_value"
    # }
    # when = create # Ist der Default, wenn nicht anders angegeben
  }
