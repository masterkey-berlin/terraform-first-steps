# Terraform: Erste Schritte mit Provider und Ressource

Dieses Projekt enthält eine einfache Terraform-Konfiguration, um die Grundlagen von Infrastructure as Code (IaC) mit Terraform zu demonstrieren.

## Aufgabe

Ziel dieser Aufgabe war es:
- Eine minimale Terraform-Konfiguration mit einem Provider (Docker) und zwei Ressourcen (Docker Image, Docker Container) zu erstellen.
- Den Terraform-Workflow (`init`, `plan`) praktisch anzuwenden.
- Das Verständnis von HCL-Syntax, Providern, Ressourcen und Abhängigkeiten zu festigen.

## Terraform-Dateien

Die Terraform-Konfigurationsdateien (`provider.tf`, `main.tf`) für diese Aufgabe befinden sich im Verzeichnis:
`terraform/first-steps/`

## Durchführung

### Voraussetzungen
- Terraform CLI installiert
- Docker installiert und laufend

### Schritte
1.  **Initialisierung:** Im Verzeichnis `terraform/first-steps/` wurde `terraform init` ausgeführt, um den Docker-Provider herunterzuladen.
    *Screenshot des `terraform init` Outputs:*
    ```
  
    ```
2.  **Planung:** Anschließend wurde `terraform plan` ausgeführt, um eine Vorschau der zu erstellenden Ressourcen zu erhalten. Der Plan zeigte die Erstellung von zwei Ressourcen an: `docker_image.nginx_image` und `docker_container.simple_nginx_container`.
    *Screenshot des `terraform plan` Outputs:*
    ```
    
    ```

## Reflexionsfragen & Antworten
Was ist die Rolle des provider Blocks in deiner Konfiguration? Warum ist er notwendig?
Antworthinweis: Erklärt Terraform, mit welcher Art von Infrastruktur (Cloud, Service) es interagieren soll (hier: Docker). Er ist notwendig, um die spezifischen API-Aufrufe für diese Infrastruktur zu ermöglichen und ggf. Authentifizierung/Konfiguration bereitzustellen.

Was ist die Rolle des resource Blocks? Was repräsentiert er im Vergleich zu einem provider?
Antworthinweis: Definiert ein spezifisches Infrastrukturobjekt (hier: ein Docker Image, ein Docker Container), das Terraform verwalten soll. Der Provider ist die "Brücke" zur Infrastruktur, die Ressource ist ein "Baustein" dieser Infrastruktur.

Wie hast du in deiner Konfiguration eine implizite Abhängigkeit zwischen der docker_container Ressource und der docker_image Ressource erstellt? Warum ist es wichtig, dass Terraform diese Abhängigkeit versteht?

Antworthinweis: Durch die Referenz image = docker_image.nginx_image.image_id. Terraform versteht, dass das Image zuerst existieren (oder heruntergeladen werden) muss, bevor der Container damit erstellt werden kann. Das stellt die korrekte Reihenfolge der Operationen sicher.

Was genau bewirkt der Befehl terraform init, wenn du ihn zum ersten Mal in einem Verzeichnis ausführst?
Antworthinweis: Lädt die benötigten Provider-Plugins herunter (basierend auf required_providers), initialisiert das Backend (hier lokal) und bereitet das Arbeitsverzeichnis für weitere Terraform-Befehle vor.

Was genau zeigt der Output von terraform plan an? Welche Informationen liefert er, bevor du die Infrastruktur tatsächlich erstellst?

Antworthinweis: Eine Vorschau der Aktionen, die Terraform durchführen würde (erstellen, ändern, zerstören von Ressourcen), um den in der Konfiguration definierten Zustand zu erreichen. Er zeigt die spezifischen Attribute und Werte der betroffenen Ressourcen und hilft, Fehler oder unerwünschte Änderungen vorab zu erkennen.

**Beispiel:**
1.  **Rolle des `provider` Blocks:** Definiert die Schnittstelle zur Zielinfrastruktur (hier Docker) und ermöglicht Terraform, deren Ressourcen zu verwalten. Notwendig für die spezifischen API-Interaktionen.
2.  **Rolle des `resource` Blocks:** Definiert ein konkretes Infrastrukturobjekt (z.B. ein Docker Image oder Container), das Terraform erstellen, ändern oder zerstören soll. Im Gegensatz zum Provider, der die "Fähigkeit" zur Interaktion bereitstellt, ist die Ressource das "Was".
3.  **Implizite Abhängigkeit:** Erstellt durch `image = docker_image.nginx_image.image_id` im `docker_container`. Terraform versteht dadurch, dass das `docker_image` vor dem `docker_container` existieren muss, und stellt die korrekte Ausführungsreihenfolge sicher.
4.  **Wirkung von `terraform init`:** Lädt die benötigten Provider-Plugins herunter (basierend auf `required_providers` in `provider.tf`), initialisiert das Backend (hier lokal) und erstellt die `.terraform.lock.hcl` Datei, um Provider-Versionen zu sperren.
5.  **Output von `terraform plan`:** Zeigt eine detaillierte Vorschau der Aktionen (+ erstellen, ~ ändern, - zerstören), die Terraform ausführen würde, um den gewünschten Zustand laut Konfiguration zu erreichen. Liefert Informationen über die zu ändernden Attribute und Werte, bevor tatsächliche Änderungen an der Infrastruktur vorgenommen werden.

*(Ende des optionalen Reflexions-Abschnitts)*

## .gitignore

Das `.terraform/` Verzeichnis, `*.tfstate` Dateien und die `*.tfvars` wurden zur `.gitignore` hinzugefügt, um heruntergeladene Plugins und sensible Zustands-/Variablendateien nicht zu versionieren. Die `.terraform.lock.hcl` wurde gemäß Aufgabenstellung ebenfalls ignoriert, obwohl ihre Versionierung oft empfohlen wird.

---

(<Screenshot 2025-06-03 205651.png>) (<Screenshot 2025-06-03 205704.png>) (<Screenshot 2025-06-03 205719.png>) (<Screenshot 2025-06-03 205730.png>) (<Screenshot 2025-06-03 205740.png>) (<Screenshot 2025-06-03 205754.png>)


# Terraform: Variablen, Outputs und Provisioner

Dieses Projekt erweitert die initiale Terraform-Konfiguration um Variablen, Outputs und einen Provisioner, um einen Docker Nginx Container dynamischer zu gestalten und zu konfigurieren.

## Aufgabe

Ziel dieser Aufgabe war es:
- Input-Variablen (`variables.tf`) mit Default-Werten zu definieren.
- Output-Werte (`outputs.tf`) zu definieren, um wichtige Informationen anzuzeigen.
- Die `main.tf` zu aktualisieren, um diese Variablen zu nutzen und die `docker_image` Ressource zu entfernen.
- Einen `local-exec` Provisioner zu verwenden, um dynamischen HTML-Inhalt in den laufenden Nginx-Container zu schreiben.
- Verschiedene Methoden zur Übergabe von Variablenwerten zu demonstrieren (`.tfvars`-Datei, Kommandozeilen-Flags, Default-Werte).
- Den vollständigen Terraform-Workflow (`init`, `plan`, `apply`, `destroy`) mit diesen Erweiterungen durchzuführen.

## Terraform-Dateien

Die Terraform-Konfigurationsdateien (`provider.tf`, `main.tf`, `variables.tf`, `outputs.tf`, `test.tfvars`) für diese Aufgabe befinden sich im Verzeichnis:
`terraform/first-steps/`

## Durchführung & Workflow

### 1. Vorbereitung
- Sicherstellen, dass Terraform CLI und Docker installiert sind und laufen.
- Arbeitsverzeichnis: `terraform/first-steps/`

### 2. Initialer Apply (Falls nicht aus vorheriger Aufgabe geschehen)
   ```bash
   terraform apply

   terraform init

   terraform plan -var-file="test.tfvars"
terraform apply -var-file="test.tfvars"

terraform apply -var-file="test.tfvars" -var="container_name=my-cli-container"

terraform apply -var-file="test.tfvars"

terraform destroy -var-file="test.tfvars"

(<Screenshot 2025-06-04 135015 - Kopie.png>) (<Screenshot 2025-06-04 135015.png>) ![alt(<Screenshot 2025-06-04 135123 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 135123.png>) ![alt text](<Screenshot 2025-06-04 135133 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 135133.png>) ![alt text](<Screenshot 2025-06-04 135242 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 135242.png>) ![alt text](<Screenshot 2025-06-04 135255 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 135255.png>) ![alt text](<Screenshot 2025-06-04 135307 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 135307.png>) ![alt text](<Screenshot 2025-06-04 135455 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 135455.png>) ![alt text](<Screenshot 2025-06-04 135559 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 135559.png>) ![alt text](<Screenshot 2025-06-04 142318 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 142318.png>) ![alt text](<Screenshot 2025-06-04 143822 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 143822.png>) ![alt text](<Screenshot 2025-06-04 143828 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 143828.png>) ![alt text](<Screenshot 2025-06-04 143834 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 143834.png>) ![alt text](<Screenshot 2025-06-04 143841 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 143841.png>) ![alt text](<Screenshot 2025-06-04 143856 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 143856.png>) ![alt text](<Screenshot 2025-06-04 144032 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 144032.png>) ![alt text](<Screenshot 2025-06-04 144111 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 144111.png>) ![alt text](<Screenshot 2025-06-04 144205 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 144205.png>) ![alt text](<Screenshot 2025-06-04 144213 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 144213.png>) ![alt text](<Screenshot 2025-06-04 144233 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 144233.png>) ![alt text](<Screenshot 2025-06-04 144520 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 144520.png>) ![alt text](<Screenshot 2025-06-04 144528 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 144528.png>) ![alt text](<Screenshot 2025-06-04 144606 - Kopie.png>) ![alt text](<Screenshot 2025-06-04 144606.png>) ![alt text](<Screenshot 2025-06-04 145044.png>) ![alt text](<Screenshot 2025-06-04 145100.png>)