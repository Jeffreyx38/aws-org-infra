resource "aws_organizations_policy" "deny_ungoverned_regions" {
  name        = "Deny-Ungoverned-Regions"
  description = "Deny actions in regions outside governed_regions"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DenyUngovernedRegions"
        Effect = "Deny"
        NotAction = [
          "iam:*",
          "organizations:*",
          "route53:*",
          "cloudfront:*",
          # add any other global exceptions you need
        ]
        Resource = "*"
        Condition = {
          StringNotEquals = {
            "aws:RequestedRegion" = var.governed_regions
          }
        }
      }
    ]
  })
}

resource "aws_organizations_policy_attachment" "deny_ungoverned_regions_root" {
  policy_id = aws_organizations_policy.deny_ungoverned_regions.id
  target_id = data.aws_organizations_organization.this.roots[0].id
}

