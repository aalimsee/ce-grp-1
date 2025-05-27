# Create S3 bucket first before terraform init
terraform {
  backend "s3" {
    bucket         = "ce-grp-1-tfstate"
    key            = "https/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ce-grp-1-tf-locks" # DynamoDB for locking
  }
}
