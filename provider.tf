provider "aws" {
  shared_credentials_file = var.credentials_file
  profile                 = var.profile
  region                  = var.region
}