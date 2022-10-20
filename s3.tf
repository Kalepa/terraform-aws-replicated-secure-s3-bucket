module "bucket_a" {
  source  = "Kalepa/secure-s3-bucket/aws"
  version = "~> 0.2"
  providers = {
    aws = aws.a
  }
  depends_on = [
    module.assert_same_account
  ]
  // Versioning always required for replication
  versioned                     = true
  name                          = var.name_a
  mfa_delete_enabled            = local.mfa_delete_enabled_a
  bucket_policy_json_documents  = concat(local.bucket_policy_json_documents_a, local.bucket_policy_json_documents_both)
  kms_key_arn                   = var.kms_key_arn_a
  create_new_kms_key            = local.create_new_kms_key_a
  create_replica_kms_key        = local.create_replica_kms_key_a
  kms_key_policy_json_documents = concat(local.kms_key_policy_json_documents_a, local.kms_key_policy_json_documents_both)
  enable_transfer_acceleration  = local.enable_transfer_acceleration_a
  block_public_acls             = local.block_public_acls_a
  block_public_policy           = local.block_public_policy_a
  ignore_public_acls            = local.ignore_public_acls_a
  restrict_public_buckets       = local.restrict_public_buckets_a
  object_ownership              = local.object_ownership_a
  append_region_suffix          = local.append_region_suffix_a
  object_lock_enabled           = local.object_lock_enabled_a
  force_destroy                 = local.force_destroy_a
  force_allow_cloudtrail_digest = local.force_allow_cloudtrail_digest_a
}

locals {
  // If a specific key was provided for bucket B, use that.
  // Otherwise, use the key that was used for bucket A as the base key
  b_kms_key_arn = var.kms_key_arn_b != null ? var.kms_key_arn_b : module.bucket_a.kms_key_arn
  // If a specific key was provided for bucket B, or we're supposed to create a new key for bucket B,
  // use the input `create_replica_kms_key_b` variable as-is.
  b_create_replica_key = var.kms_key_arn_b != null || local.create_new_kms_key_b ? local.create_replica_kms_key_b : (
    // Otherwise, check if a key was used for Bucket A (one provided, or new one created)
    var.kms_key_arn_a != null || local.create_new_kms_key_a ? (
      // If a key was used for bucket A, only create a replica for bucket B if B is in a different region
      data.aws_region.a.name != data.aws_region.b.name
      ) : (
      // No key was used for bucket A, so we don't need a replica key for bucket B
      false
    )
  )
}

module "bucket_b" {
  source  = "Kalepa/secure-s3-bucket/aws"
  version = "~> 0.2"
  providers = {
    aws = aws.b
  }
  depends_on = [
    module.assert_same_account
  ]
  // Versioning always required for replication
  versioned                     = true
  name                          = var.name_b
  mfa_delete_enabled            = local.mfa_delete_enabled_b
  bucket_policy_json_documents  = concat(local.bucket_policy_json_documents_b, local.bucket_policy_json_documents_both)
  kms_key_arn                   = local.b_kms_key_arn
  create_new_kms_key            = local.create_new_kms_key_b
  create_replica_kms_key        = local.b_create_replica_key
  kms_key_policy_json_documents = concat(local.kms_key_policy_json_documents_b, local.kms_key_policy_json_documents_both)
  enable_transfer_acceleration  = local.enable_transfer_acceleration_b
  block_public_acls             = local.block_public_acls_b
  block_public_policy           = local.block_public_policy_b
  ignore_public_acls            = local.ignore_public_acls_b
  restrict_public_buckets       = local.restrict_public_buckets_b
  object_ownership              = local.object_ownership_b
  append_region_suffix          = local.append_region_suffix_b
  object_lock_enabled           = local.object_lock_enabled_b
  force_destroy                 = local.force_destroy_b
  force_allow_cloudtrail_digest = local.force_allow_cloudtrail_digest_b
}

module "replication" {
  source  = "Kalepa/secure-s3-bucket-replication/aws"
  version = "~> 0.1"
  providers = {
    aws.a = aws.a
    aws.b = aws.b
  }
  bucket_a_module  = module.bucket_a
  bucket_b_module  = module.bucket_b
  replicate_a_to_b = var.replicate_a_to_b
  replicate_b_to_a = var.replicate_b_to_a
  a_to_b_rules     = local.a_to_b_rules
  b_to_a_rules     = local.b_to_a_rules
}
