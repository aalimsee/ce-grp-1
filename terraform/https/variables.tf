
variable "createdByTerraform" {
  type    = string
  default = "Managed by Terraform - ce-grp-1"
}

# Switch to True, Use terraform plan|apply -var="use_https=true"
variable "use_https" {
  description = "Controls whether the listener should use port 443 (HTTPS) or 80 (HTTP)."
  type        = bool
  default     = false
}

# Route 53 information
variable "route53_zone" {
  default = "sctp-sandbox.com"
}
variable "route53_subdomain" {
  default = "ce-grp-1"
}

variable "key_pair" {
  type    = string
  default = "ce-grp-1-keypair"
}