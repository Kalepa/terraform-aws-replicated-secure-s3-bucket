module "assert_same_account" {
  source        = "Kalepa/assertion/null"
  version       = "~> 0.2"
  condition     = data.aws_caller_identity.a.account_id == data.aws_caller_identity.b.account_id
  error_message = "Replication may only be configured with this module for two buckets in the same AWS account."
}
