# Existing Route 53 Hosted Zone
data "aws_route53_zone" "existing_zone" {
  name = var.route53_zone
}

# Route 53 Record for Web Load Balancer
resource "aws_route53_record" "public_alb" {
  zone_id = data.aws_route53_zone.existing_zone.id
  name    = var.route53_subdomain # Subdomain for the web service
  type    = "A"
  alias {
    name                   = aws_lb.public_alb.dns_name
    zone_id                = aws_lb.public_alb.zone_id
    evaluate_target_health = true
  }
}

# Request ACM Certificate for your domain
resource "aws_acm_certificate" "https_cert" {
  domain_name       = "${var.route53_subdomain}.${var.route53_zone}" # Replace with your subdomain
  validation_method = "DNS"

  tags = {
    Name      = "${var.route53_subdomain}-HTTPS-Certificate"
    CreatedBy = var.createdByTerraform
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create DNS validation records in the existing Route 53 Hosted Zone
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.https_cert.domain_validation_options :
    dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.existing_zone.id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.value]
  ttl     = 300
}

# Validate the ACM Certificate
resource "aws_acm_certificate_validation" "https_cert_validation" {
  certificate_arn = aws_acm_certificate.https_cert.arn

  validation_record_fqdns = [
    for record in aws_route53_record.cert_validation : record.fqdn
  ]
}
