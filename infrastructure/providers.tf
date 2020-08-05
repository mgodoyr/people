//provider "mongodbatlas" {}
provider "google" {
  credentials = file("terraform-credentials-95fa2872f9f9.json")
  project     = var.project
  region      = var.region
}
provider "google-beta" {
  version = "~> 2.9.0"
  credentials = file("terraform-credentials-95fa2872f9f9.json")
  project = var.project
  region  = var.region
}
terraform{
  required_version = ">= 0.12"
  backend "gcs"{
    prefix      = "people"
    credentials = "terraform-credentials-95fa2872f9f9.json"
    bucket      = "terraform-states-gridtrue"
  }
}