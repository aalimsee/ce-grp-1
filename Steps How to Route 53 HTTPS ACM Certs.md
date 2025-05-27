Suggested File Structure
Copy
Edit
infra/
├── cert/
│   └── acm.tf
├── dns/
│   └── route53.tf

✅ 1. ACM Certificate for HTTPS (in cert/acm.tf)
hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_acm_certificate" "cert_ce_grp_1" {
  domain_name       = "ce-grp-1.sctp-sandbox.com"
  validation_method = "DNS"

  tags = {
    Environment = "prod"
    Project     = "ce-grp-1"
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert_ce_grp_1.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.primary.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert_ce_grp_1.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

✅ 2. Route 53 DNS Record (in dns/route53.tf)
hcl
data "aws_route53_zone" "primary" {
  name         = "sctp-sandbox.com."
  private_zone = false
}

resource "aws_route53_record" "ce_grp_1_alias" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "ce-grp-1"
  type    = "A"

  alias {
    name                   = "k8s-prod-nginxingr-abc123.elb.us-east-1.amazonaws.com" # replace with actual ALB DNS
    zone_id                = "Z32O12XQLNTSW2" # hosted zone ID for ALB in us-east-1 (static)
    evaluate_target_health = true
  }
}

✅ The zone_id for ALB in us-east-1 is always Z32O12XQLNTSW2 (for *.elb.amazonaws.com)

🛠 How to Use
bash
cd infra
terraform init
terraform apply
