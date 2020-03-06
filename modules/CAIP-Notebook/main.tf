# Copyright 2020 Google LLC. This software is provided as-is, without
#  warranty or representation for any use or purpose. Your use of it 
# is subject to your agreement with Google. 


# CAIP Notebook Terraform Module
# This module creates a CAIP notebook.

resource "google_service_account" "service_account" {
  account_id   = var.service_account_id
  display_name = "Service Account for ${var.instance_name}."
}

resource "google_compute_instance" "caip_notebook" {
  name = var.instance_name
  machine_type = var.machine_type
  zone = var.compute_zone
  can_ip_forward = false
  project = var.project_id

  tags = var.tags

  boot_disk {
    initialize_params {
      image = "deeplearning-platform-release/${var.dl_image_name}"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    proxy-mode="project_editors"
  }

  metadata_startup_script = <<SCRIPT
  pip install tf-nightly
  echo "export TPU_NAME=${var.tpu_name}" > /etc/profile.d/tpu-env.sh
  SCRIPT

  service_account {
    email = "${var.service_account_id}@${var.project_id}.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

}