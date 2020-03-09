# Copyright 2020 Google LLC. This software is provided as-is, without
#  warranty or representation for any use or purpose. Your use of it 
# is subject to your agreement with Google. 


# CAIP Notebook Terraform Module
# This module creates a CAIP notebook.

variable "sa-account-id" {
    description="Name for CAIP notebook SA"
    default = "CAIP-notebook-sa"
}

variable "project-id" {
    description="Project ID"
    default = "mikebernico-sandbox"
}

variable "compute-zone" {
    description="Compute Zone"
    default = "us-central1-c"
}

variable "notebook-name" {
    description="Notebook Name"
    default = "caip-notebook"
}