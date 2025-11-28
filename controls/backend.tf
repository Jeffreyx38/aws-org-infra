terraform {
  backend "s3" {
    bucket         = "jzbx-terraform-state"
    key            = "controls/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
