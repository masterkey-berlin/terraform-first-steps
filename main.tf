# main.tf

resource "docker_image" "nginx_image" {
  name         = "nginx:latest" # Lädt das 'nginx:latest' Image von Docker Hub
  keep_locally = false         # Optional: Entfernt das Image lokal, wenn die Ressource zerstört wird
}

resource "docker_container" "simple_nginx_container" {
  name  = "my-nginx-container-tf" # Name des Docker Containers, der erstellt wird
  image = docker_image.nginx_image.image_id # Referenziert das oben definierte Image über seine ID

  ports {
    internal = 80 # Interner Port des Containers (Nginx lauscht auf Port 80)
    # external = 8080 # Optional: Mappt den internen Port auf einen externen Host-Port
                     # Für diesen ersten Test können wir das weglassen, um Komplexität zu reduzieren.
                     # Wenn du es testen willst, stelle sicher, dass Port 8080 frei ist.
  }
}