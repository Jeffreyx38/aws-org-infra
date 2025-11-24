############################
# AWSControlTowerAdmin
############################

resource "aws_iam_role" "aws_controltower_admin" {
  name = "AWSControlTowerAdmin"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "controltower.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach the AWS-managed service role policy
resource "aws_iam_role_policy_attachment" "aws_controltower_admin_service_role_policy" {
  role       = aws_iam_role.aws_controltower_admin.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSControlTowerServiceRolePolicy"
}

############################
# AWSControlTowerCloudTrailRole
############################

resource "aws_iam_role" "aws_controltower_cloudtrail_role" {
  name = "AWSControlTowerCloudTrailRole"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "aws_controltower_cloudtrail_role_policy" {
  role       = aws_iam_role.aws_controltower_cloudtrail_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSControlTowerCloudTrailRolePolicy"
}

############################
# AWSControlTowerStackSetRole
############################

resource "aws_iam_role" "aws_controltower_stackset_role" {
  name = "AWSControlTowerStackSetRole"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "cloudformation.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "aws_controltower_stackset_role_policy" {
  role       = aws_iam_role.aws_controltower_stackset_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSControlTowerStackSetRolePolicy"
}
############################
# AWSControlTowerConfigAggregatorRoleForOrganizations
############################

resource "aws_iam_role" "aws_controltower_config_aggregator_role" {
  name = "AWSControlTowerConfigAggregatorRoleForOrganizations"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "config.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "aws_controltower_config_aggregator_role_policy" {
  role       = aws_iam_role.aws_controltower_config_aggregator_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}
