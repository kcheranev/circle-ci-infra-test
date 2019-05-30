terraform {
  backend "s3" {
    endpoint = "hb.bizmrg.com"
    bucket = "otpb"
    key = "terraform/state/x-sell.tfstate"
    shared_credentials_file = "s3-credentials.conf"
    region = "us-east-1"
    force_path_style = true
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
  }
}