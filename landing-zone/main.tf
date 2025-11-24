locals {
  landing_zone_version = "3.3" # adjust if docs show a newer version
}

resource "aws_controltower_landing_zone" "this" {
  version = local.landing_zone_version

  manifest_json = jsonencode({
    homeRegion      = var.home_region
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

  # optional tags
  tags = {
    Environment = "platform"
    Owner       = "platform-team"
  }
}
