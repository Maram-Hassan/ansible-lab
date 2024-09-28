terraform {
  backend "s3" {
    bucket = "s3_bucket"
    key    = "terraform.tf"
    region = "us-east-1"
    dynamodb_table = "terraform_locks"
  }
}




