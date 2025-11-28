data "aws_organizations_organization" "this" {}

data "aws_organizations_organizational_units" "root_children" {
  parent_id = data.aws_organizations_organization.this.roots[0].id
}

locals {
  ou_by_name = {
    for ou in data.aws_organizations_organizational_units.root_children.children :
    ou.name => ou.id
  }

  security_ou_id      = local.ou_by_name["Security"]
#   sandbox_ou_id       = local.ou_by_name["Sandbox"]
#   workloads_prod_ou_id  = local.ou_by_name["Workloads-Prod"]
#   workloads_nonprod_ou_id = local.ou_by_name["Workloads-NonProd"]
#   infrastructure_ou_id = local.ou_by_name["Infrastructure"]
}
