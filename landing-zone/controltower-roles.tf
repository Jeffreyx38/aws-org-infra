############################
# AWSControlTowerAdmin
############################

resource "aws_iam_role" "aws_controltower_admin" {
  name = "AWSControlTowerAdmin"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "controltower.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Inline policy: AWSControlTowerAdminPolicy
resource "aws_iam_role_policy" "aws_controltower_admin_inline" {
  name = "AWSControlTowerAdminPolicy"
  role = aws_iam_role.aws_controltower_admin.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "ec2:DescribeAvailabilityZones"
        Resource = "*"
      }
    ]
  })
}

# Managed policy: AWSControlTowerServiceRolePolicy
resource "aws_iam_role_policy_attachment" "aws_controltower_admin_service_role_policy" {
  role       = aws_iam_role.aws_controltower_admin.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSControlTowerServiceRolePolicy"
}


############################
# AWSControlTowerStackSetRole
############################

resource "aws_iam_role" "aws_controltower_stackset_role" {
  name = "AWSControlTowerStackSetRole"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudformation.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Inline policy that matches the doc
resource "aws_iam_role_policy" "aws_controltower_stackset_inline" {
  name = "AWSControlTowerStackSetRolePolicy"
  role = aws_iam_role.aws_controltower_stackset_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sts:AssumeRole"
        ]
        Resource = [
          "arn:aws:iam::*:role/AWSControlTowerExecution"
        ]
      }
    ]
  })
}


############################
# AWSControlTowerCloudTrailRole
############################

resource "aws_iam_role" "aws_controltower_cloudtrail_role" {
  name = "AWSControlTowerCloudTrailRole"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aws_controltower_cloudtrail_managed_policy" {
  role       = aws_iam_role.aws_controltower_cloudtrail_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSControlTowerCloudTrailRolePolicy"
}


# resource "aws_iam_role_policy" "aws_controltower_cloudtrail_inline" {
#   name = "AWSControlTowerCloudTrailRolePolicy"
#   role = aws_iam_role.aws_controltower_cloudtrail_role.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect   = "Allow"
#         Action   = "logs:CreateLogStream"
#         Resource = "arn:aws:logs:*:*:log-group:aws-controltower/CloudTrailLogs:*"
#       },
#       {
#         Effect   = "Allow"
#         Action   = "logs:PutLogEvents"
#         Resource = "arn:aws:logs:*:*:log-group:aws-controltower/CloudTrailLogs:*"
#       }
#     ]
#   })
# }

############################
# AWSControlTowerConfigAggregatorRoleForOrganizations
############################

resource "aws_iam_role" "aws_controltower_config_aggregator_role" {
  name = "AWSControlTowerConfigAggregatorRoleForOrganizations"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "config.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aws_controltower_config_aggregator_role_policy" {
  role       = aws_iam_role.aws_controltower_config_aggregator_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}

