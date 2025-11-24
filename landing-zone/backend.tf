terraform {
  backend "s3" {
    bucket         = "jzbx-terraform-state" # your bucket from Phase 0
    key            = "landing-zone/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
