# Terraform google cloud multi tier deployment

provider "google" {
    credentials = file("agisit-2223-calculator-02-58773ee1ef5a.json")
    project = var.GCP_PROJECT_ID
    zone = var.GCP_ZONE
}
