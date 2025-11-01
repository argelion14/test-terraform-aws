terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.15.0"
    }
  }

  backend "s3" {
    # Se rellena automáticamente por workflow (STATE_CONFIG_PATH)
  }
}

provider "aws" {
  region = var.aws_region
}

# 🪣 Crear bucket S3
resource "aws_s3_bucket" "tf_test_bucket" {
  bucket = "argelion14-tf-test-bucket-${random_id.rand.hex}"
  force_destroy = true
  tags = {
    Name = "TF Test Bucket"
    Environment = var.environment
  }
}

resource "random_id" "rand" {
  byte_length = 4
}

# 💻 Crear instancia EC2 básica
# resource "aws_instance" "tf_test_instance" {
#   ami           = "ami-0c7217cdde317cfec" # Amazon Linux 2 (eu-west-1)
#   instance_type = "t2.micro"

#   tags = {
#     Name        = "TF Test EC2"
#     Environment = var.environment
#   }
# }
