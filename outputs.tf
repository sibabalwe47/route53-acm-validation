output "acm_id" {
  value = aws_acm_certificate.acm_ssl_certificate.id
}

output "acm_arn" {
  value = aws_acm_certificate.acm_ssl_certificate.arn
}

output "acm_domain_name" {
  value = aws_acm_certificate.acm_ssl_certificate.domain_name
}

output "acm_validation_options" {
  value = aws_acm_certificate.acm_ssl_certificate.domain_validation_options
}

output "acm_subject_alternative_names" {
  value = aws_acm_certificate.acm_ssl_certificate.subject_alternative_names
}
