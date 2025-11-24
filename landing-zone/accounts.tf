# Create the AWS Organization (turns this account into the management account)
resource "aws_organizations_organization" "this" {
  feature_set = "ALL"
}

# Log Archive account
resource "aws_organizations_account" "log_archive" {
  name      = "Jzbx-LogArchive"
  email     = var.log_archive_email
  role_name = "OrganizationAccountAccessRole"

  depends_on = [aws_organizations_organization.this]
}

# Audit / Security account
resource "aws_organizations_account" "audit" {
  name      = "Jzbx-Audit"
  email     = var.audit_email
  role_name = "OrganizationAccountAccessRole"

  depends_on = [aws_organizations_organization.this]
}
