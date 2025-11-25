# Create the AWS Organization (turns this account into the management account)
resource "aws_organizations_organization" "this" {
  feature_set = "ALL"
}

resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = aws_organizations_organization.this.roots[0].id
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

resource "aws_organizations_move_account" "log_archive_to_security" {
  account_id            = aws_organizations_account.log_archive.id
  source_parent_id      = aws_organizations_organization.this.roots[0].id
  destination_parent_id = aws_organizations_organizational_unit.security.id
}

resource "aws_organizations_move_account" "audit_to_security" {
  account_id            = aws_organizations_account.audit.id
  source_parent_id      = aws_organizations_organization.this.roots[0].id
  destination_parent_id = aws_organizations_organizational_unit.security.id
}

