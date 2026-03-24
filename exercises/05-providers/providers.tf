terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 6.0, <7.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "eu-west-1"
  alias  = "eu-west"
}

resource "aws_s3_bucket" "us-east-1" {
  bucket = "terraform-bucket-east-davis"
}

resource "aws_s3_bucket" "eu-west-1" {
  bucket   = "terraform-bucket-west-davis"
  provider = aws.eu-west
}
