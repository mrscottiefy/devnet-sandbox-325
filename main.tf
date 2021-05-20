terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.32.0"
    }
  }
}

provider "aws" {
  profile = "dev-aws"
  region  = "ap-southeast-1"
}

locals {
  vpc_id                 = "vpc-0c7869fb70b78e2f9"
  public_subnet_az_a_id  = "subnet-0b426229916942e24" //sub-a-devnet-sbxezit-IT01
  public_subnet_az_b_id  = "subnet-0782e33d3e8c212c4" //sub-b-devnet-sbxezit-IT02
  private_subnet_az_a_id = ""
  private_subnet_az_b_id = ""

  default_tags = {
    /* Agency-Code  = "hdb"
    Project-Code = "jenk01"
    Zone         = "dz"
    Environment  = "t01" */
  }
}


resource "aws_directory_service_directory" "sandbox-domain-service" {
  name     = "soedev.sgnet.gov.sg"
  password = "SuperSecretPassw0rd"
  edition  = "Standard"
  type     = "MicrosoftAD"

  vpc_settings {
    vpc_id     = local.vpc_id
    subnet_ids = [local.public_subnet_az_a_id, aws_subnet.public_subnet_az_b_id]
  }

  tags = {
    Project = "foo"
  }
}