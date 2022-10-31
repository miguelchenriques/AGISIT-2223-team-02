
# Elemets of the cloud such as virtual servers,
# networks, firewall rules are created as resources
# syntax is: resource RESOURCE_TYPE RESOURCE_NAME
# https://www.terraform.io/docs/configuration/resources.html

resource "google_compute_firewall" "frontend_rules" {
  name    = "frontend"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["frontend"]
}

resource "google_compute_firewall" "operations_rules" {
  name    = "operations"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["3000"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["operations"]
}

resource "google_compute_firewall" "balancer_rules" {
  name    = "balancer"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80", "443", "3001"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["balancer"]
}