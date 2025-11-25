resource "aws_controltower_landing_zone" "this" {
  version = var.landing_zone_version

  manifest_json = jsonencode({
    governedRegions = var.governed_regions

    centralizedLogging = {
      # CT will treat this account as Log Archive
      accountId = aws_organizations_account.log_archive.id
      enabled   = true
      configurations = {
        loggingBucket = {
          retentionDays = 3650
        }
        accessLoggingBucket = {
          retentionDays = 3650
        }
      }
    }

    securityRoles = {
      enabled = true
      # CT will treat this account as Audit / Security
      accountId = aws_organizations_account.audit.id
    }

    accessManagement = {
      enabled = true
      # We'll configure IAM Identity Center/SSO in a later phase
    }

    backup = {
      # we’re not using CT-managed Backup yet
      enabled = false
    }

    config = {
      # Config aggregator account (use Audit/Security account)
      accountId = aws_organizations_account.audit.id
      enabled   = true

      configurations = {
        loggingBucket = {
          retentionDays = 365
        }
        accessLoggingBucket = {
          retentionDays = 365
        }
        # kmsKeyArn = "arn:aws:kms:region:account-id:key/key-id"
      }
    }
  })

  depends_on = [
    aws_iam_role.aws_controltower_admin,
    aws_iam_role.aws_controltower_cloudtrail_role,
    aws_iam_role.aws_controltower_stackset_role,
    aws_iam_role.aws_controltower_config_aggregator_role,
    aws_organizations_organizational_unit.security,
    aws_organizations_account.log_archive,
    aws_organizations_account.audit,
  ]

  # optional tags
  tags = {
    Environment = "platform"
    Owner       = "platform-team"
  }
}
