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

![alt text](<Screenshot (4034).png>) ![alt text](<Screenshot (4029).png>) ![alt text](<Screenshot (4030).png>) ![alt text](<Screenshot (4031).png>) ![alt text](<Screenshot (4032).png>) ![alt text](<Screenshot (4033).png>)
