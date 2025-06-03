# provider.tf

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0" # Stellt sicher, dass eine Version 3.x verwendet wird
    }
  }
}

provider "docker" {
  # Konfiguration für den Docker Provider, um mit deinem lokalen Docker Daemon zu kommunizieren.
  # Für Linux/macOS ist "unix:///var/run/docker.sock" üblich.
  # Für Windows mit Docker Desktop (wenn WSL2 Backend genutzt wird) ist dies auch oft korrekt.
  # Alternativ, wenn Docker über TCP exponiert ist (weniger üblich für lokale Setups):
  # host = "tcp://localhost:2375"
  # Überprüfe deine Docker-Konfiguration, wenn du unsicher bist.
  # Für die meisten Standard-Docker-Desktop-Installationen ist keine explizite 'host'-Konfiguration hier nötig,
  # da der Provider versucht, Standardpfade zu finden. Aber es explizit anzugeben ist guter Stil.
  # Wenn dein Docker Daemon ohne TLS auf einem TCP Port lauscht (z.B. localhost:2375),
  # dann kannst du das hier konfigurieren.
  # host = "tcp://localhost:2375" # Beispiel, falls nötig
}