resource "aws_controltower_landing_zone" "this" {
  version = var.landing_zone_version

  manifest_json = jsonencode({
    governedRegions = var.governed_regions

    organizationStructure = {
      security = {
        name = "Security"
      }
      sandbox = {
        name = "Sandbox"
      }
      # You will create other OUs (Infrastructure, Workloads-Prod, etc.)
      # in a later phase with Organizations + CT or separate stacks.
    }

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
      # CT will treat this account as Audit / Security
      accountId = aws_organizations_account.audit.id
    }

    accessManagement = {
      enabled = true
      # We'll configure IAM Identity Center/SSO in a later phase
    }
  })

  depends_on = [
    aws_iam_role.aws_controltower_admin,
    aws_iam_role.aws_controltower_cloudtrail_role,
    aws_iam_role.aws_controltower_stackset_role,
    aws_iam_role.aws_controltower_config_aggregator_role,
  ]

  # optional tags
  tags = {
    Environment = "platform"
    Owner       = "platform-team"
  }
}
