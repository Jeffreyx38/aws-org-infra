variable "governed_regions" {
  type        = list(string)
  description = "Regions where workloads are allowed."
  default     = ["us-east-1", "us-west-2"]
}
