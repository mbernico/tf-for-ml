provider "google" {
  project = "mikebernico-sandbox"
}

#data "google_iam_policy" "compute-admin" {
#  binding {
#    role = "roles/compute.admin"
#    members = []
#  }
#}

resource "google_service_account" "service_account" {
  account_id   = var.sa-account-id
  display_name = var.sa-account-id
  description = "Service Account for CAIP Notebook instance."

  # Service account creation is eventually consistent, so add a delay.
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

resource "google_project_iam_binding" "notebook-sa-compute-admin-role" {
    role    = "roles/compute.admin"
     members = [
         "serviceAccount:${var.sa-account-id}@${var.project-id}.iam.gserviceaccount.com"
     ]
 }

 resource "google_project_iam_binding" "notebook-sa-iam-user-role" {
    role    = "roles/iam.serviceAccountUser"
     members = [
         "serviceAccount:${var.sa-account-id}@${var.project-id}.iam.gserviceaccount.com"
     ]
 }


 resource "google_project_iam_binding" "notebook-sa-log-writter-role" {
    role    = "roles/roles/logging.logWriter"
     members = [
         "serviceAccount:${var.sa-account-id}@${var.project-id}.iam.gserviceaccount.com"
     ]
 }
#resource "google_service_account_iam_policy" "compute-admin-account-iam" {
#  service_account_id = google_service_account.service_account.name
#  policy_data        = data.google_iam_policy.compute-admin.policy_data
#}

#resource "google_project_iam_member" "project" {
#  project = "mikebernico-sandbox"
#  role    = "roles/compute.admin"
#  member  = "serviceAccount:mikebernico-notebook-sa@mikebernico-sandbox.iam.gserviceaccount.com"
# }

module "caip_notebook" {
  source = "../modules/CAIP-Notebook"
  instance_name = var.notebook-name
  service_account_id = var.sa-account-id
  project_id = var.project-id
  compute_zone = var.compute-zone
}