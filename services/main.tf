provider "google" {
  project = "mikebernico-sandbox"
}

resource "google_service_account" "service_account" {
  account_id   = "mikebernico-notebook-sa"
  display_name = "Service Account for CAIP Notebook instance."
}

module "caip_notebook" {
  source = "../modules/CAIP-Notebook"
  instance_name = "mikebernico-notebook"
  service_account_id = "mikebernico-notebook-sa"
  project_id = "mikebernico-sandbox"
  compute_zone = "us-central1-c"
}
