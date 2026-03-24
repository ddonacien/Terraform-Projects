terraform {
  required_provider {
    aws = { 
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

# Actively locally managed
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "var.bucket_name"
}

# Externally managed data
data "aws_s3_bucket" "external_data_bucket" {
  bucket = "outside-resource"
}

# Variable block for when the bucket name can change for the resource bucket
variable "bucket_name" {
  type        = string
  description = "My variable used to set bucket name"
  default     = "tf_demo_bucket"
}

output "bucket_id" {
  value = aws_s3_bucket.demo_bucket.id
}

locals {
  local_example = "This is a local variable"
}

module "demo_module" {
  source = "./module-example"
}
