variable "region" {
  description = "Stores the default region for deploying infrastructure."
  default     = "us-east-1"
}

variable "module_name" {
  default = "ssl-certificate-validation"
}

variable "domain_name" {

}

variable "subdomain_name" {

}

variable "version_number" {
  default = "1.1"
}

# data "aws_acm_certificate" "acm_certification" {
#   domain      = var.domain_name
#   types       = ["AMAZON_ISSUED"]
#   most_recent = true
# }


