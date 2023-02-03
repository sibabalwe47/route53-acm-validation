terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}

resource "aws_acm_certificate" "acm_ssl_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  subject_alternative_names = [
    "*.thinkkloudpodcast.co.za",
    "api.thinkkloudpodcast.co.za",
    "auth.thinkkloudpodcast.co.za",
    "accounts.thinkkloudpodcast.co.za",
    "todos.thinkkloudpodcast.co.za"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "domain_name_hosted_zone" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "acm_validation_options_records" {
  for_each = {
    for dvo in aws_acm_certificate.acm_ssl_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.domain_name_hosted_zone.zone_id
}

resource "aws_acm_certificate_validation" "acm_validation" {
  certificate_arn         = aws_acm_certificate.acm_ssl_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation_options_records : record.fqdn]
}
