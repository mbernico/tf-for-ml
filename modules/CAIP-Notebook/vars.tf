# Copyright 2020 Google LLC. This software is provided as-is, without
#  warranty or representation for any use or purpose. Your use of it 
# is subject to your agreement with Google. 


# CAIP Notebook Terraform Module
# This module creates a CAIP notebook.

variable "instance_name" {
    description = "The name of the CAIP Notebook Resource created."
    default = "caip-notebook"
}

variable "machine_type" {
    description = "The machine type used to create the instance."
    default = "n1-standard-8"
}

variable "compute_zone" {
    description = "The compute zone the notebook instance will be created in."
    default = "us-central1-a"
}

variable "tags" {
    description = "Tags to associate with the instance."
    type="list"
    default = ["caip-notebook"]
}

variable "dl_image_name" {
    description = "Deep Learning Image Name (Find with gcloud compute images list --project deeplearning-platform-release)"
    default = "tf2-latest-cpu"
}

variable "tpu_name" {
  description = "Name of a TPU"
}
