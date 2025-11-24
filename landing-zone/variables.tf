variable "home_region" {
  description = "Control Tower home region"
  type        = string
  default     = "us-east-1"
}

variable "governed_regions" {
  description = "Regions governed by Control Tower"
  type        = list(string)
  default     = ["us-east-1", "us-west-2"]
}

variable "log_archive_email" {
  description = "Root email for the Log Archive account"
  type        = string
}

variable "audit_email" {
  description = "Root email for the Audit (Security) account"
  type        = string
}
