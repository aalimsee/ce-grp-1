
# Request ACM Certificate for your domain
resource "aws_acm_certificate" "https_cert" {
  domain_name       = "${var.route53_subdomain}.${var.route53_zone}" # Replace with your subdomain
  validation_method = "DNS"

  tags = {
    Name        = "${var.route53_subdomain}-HTTPS-Certificate"
    CreatedBy   = var.createdByTerraform
    Environment = "prod"
    Project     = "ce-grp-1"
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
  validation_record_fqdns = [for record in
    aws_route53_record.cert_validation : record.fqdn
  ]
}


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
    # name                   = aws_lb.public_alb.dns_name
    # zone_id                = aws_lb.public_alb.zone_id
    # name                   = "k8s-cegrp1-498cc35dc8-629768.us-east-1.elb.amazonaws.com" # replace with actual ALB DNS from Argo deployment
    # zone_id                = "Z35SXDOTRQ7X7K"                                           # <-- must match ALB’s Hosted Zone ID                                # hosted zone ID for ALB in us-east-1 (static)

    name                   = "k8s-prod-cegrp1in-67b93fd9b4-188403575.us-east-1.elb.amazonaws.com" # replace with actual ALB DNS from Argo deployment
    zone_id                = "Z35SXDOTRQ7X7K"                                                     # <-- must match ALB’s Hosted Zone ID                                # hosted zone ID for ALB in us-east-1 (static)
    evaluate_target_health = true
  }
}



# =========================== TEST ===============================

# Request ACM Certificate for your domain
resource "aws_acm_certificate" "https_cert_test" {
  domain_name       = "${var.route53_subdomain_test}.${var.route53_zone}" # Replace with your subdomain
  validation_method = "DNS"

  tags = {
    Name        = "${var.route53_subdomain_test}-HTTPS-Certificate"
    CreatedBy   = var.createdByTerraform
    Environment = "test"
    Project     = "ce-grp-1"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# Create DNS validation records in the existing Route 53 Hosted Zone
resource "aws_route53_record" "cert_validation_test" {
  for_each = {
    for dvo in aws_acm_certificate.https_cert_test.domain_validation_options :
    dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.existing_zone_test.id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.value]
  ttl     = 300
}

# Validate the ACM Certificate
resource "aws_acm_certificate_validation" "https_cert_validation_test" {
  certificate_arn = aws_acm_certificate.https_cert_test.arn
  validation_record_fqdns = [for record in
    aws_route53_record.cert_validation_test : record.fqdn
  ]
}


# Existing Route 53 Hosted Zone
data "aws_route53_zone" "existing_zone_test" {
  name = var.route53_zone
}

# Route 53 Record for Web Load Balancer
resource "aws_route53_record" "public_alb_test" {
  zone_id = data.aws_route53_zone.existing_zone_test.id
  name    = var.route53_subdomain_test # Subdomain for the web service
  type    = "A"
  alias {
    # name                   = aws_lb.public_alb.dns_name
    # zone_id                = aws_lb.public_alb.zone_id
    name                   = "k8s-cegrp1-498cc35dc8-62976X.us-east-1.elb.amazonaws.com" # replace with actual ALB DNS from Argo deployment
    zone_id                = "Z35SXDOTRQ7X7K"                                           # <-- must match ALB’s Hosted Zone ID                                # hosted zone ID for ALB in us-east-1 (static)
    evaluate_target_health = true
  }
}




# =========================== DEV ===============================

# Request ACM Certificate for your domain
resource "aws_acm_certificate" "https_cert_dev" {
  domain_name       = "${var.route53_subdomain_dev}.${var.route53_zone}" # Replace with your subdomain
  validation_method = "DNS"

  tags = {
    Name        = "${var.route53_subdomain_dev}-HTTPS-Certificate"
    CreatedBy   = var.createdByTerraform
    Environment = "dev"
    Project     = "ce-grp-1"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# Create DNS validation records in the existing Route 53 Hosted Zone
resource "aws_route53_record" "cert_validation_dev" {
  for_each = {
    for dvo in aws_acm_certificate.https_cert_dev.domain_validation_options :
    dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.existing_zone_dev.id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.value]
  ttl     = 300
}

# Validate the ACM Certificate
resource "aws_acm_certificate_validation" "https_cert_validation_dev" {
  certificate_arn = aws_acm_certificate.https_cert_dev.arn
  validation_record_fqdns = [for record in
    aws_route53_record.cert_validation_dev : record.fqdn
  ]
}


# Existing Route 53 Hosted Zone
data "aws_route53_zone" "existing_zone_dev" {
  name = var.route53_zone
}

# Route 53 Record for Web Load Balancer
resource "aws_route53_record" "public_alb_dev" {
  zone_id = data.aws_route53_zone.existing_zone_dev.id
  name    = var.route53_subdomain_dev # Subdomain for the web service
  type    = "A"
  alias {
    # name                   = aws_lb.public_alb.dns_name
    # zone_id                = aws_lb.public_alb.zone_id
    name                   = "k8s-cegrp1-498cc35dc8-62976X.us-east-1.elb.amazonaws.com" # replace with actual ALB DNS from Argo deployment
    zone_id                = "Z35SXDOTRQ7X7K"                                           # <-- must match ALB’s Hosted Zone ID                                # hosted zone ID for ALB in us-east-1 (static)
    evaluate_target_health = true
  }
}

