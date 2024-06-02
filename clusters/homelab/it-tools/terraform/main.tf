variable "dns_zone_name" {
  default = "blocknothing.org"
  type    = string
}

variable "external_ip" {
  default = "73.92.13.198"
  type    = string
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {}

data "aws_route53_zone" "bn" {
  name         = var.dns_zone_name
  private_zone = false
}

resource "aws_route53_record" "it-tools" {
  zone_id         = data.aws_route53_zone.bn.id
  name            = "it-tools.${var.dns_zone_name}"
  type            = "A"
  ttl             = 60
  records         = [var.external_ip]
  allow_overwrite = true
}
