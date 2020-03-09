provider "google" {
  project = "mikebernico-sandbox"
}

resource "google_service_account" "service_account" {
  account_id   = "mikebernico-notebook-sa"
  display_name = "mikebernico-notebook-sa"
  description = "Service Account for CAIP Notebook instance."

    # Service account creation is eventually consistent, so add a delay.
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

resource "google_project_iam_member" "project" {
  project = "mikebernico-sandbox"
  role    = "roles/compute.admin"
  member  = "serviceAccount:mikebernico-notebook-sa@mikebernico-sandbox.iam.gserviceaccount.com"
}

module "caip_notebook" {
  source = "../modules/CAIP-Notebook"
  instance_name = "mikebernico-notebook"
  service_account_id = "mikebernico-notebook-sa"
  project_id = "mikebernico-sandbox"
  compute_zone = "us-central1-c"
}
