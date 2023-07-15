terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.8.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

# Configure provider
provider "aws" {
  region = "us-east-1"

  # static credentials
  access_key = "my-access-key"
  secret_key = "my-secret-key"

  # shared credentials/configuration file
  shared_credentials_file = "/Users/tf_user/.aws/creds"
  profile                 = "customprofile"

  # environment variables
}