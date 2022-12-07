variable "name_a" {
  description = "The name to use for bucket A."
  type        = string
  validation {
    condition     = var.name_a != null
    error_message = "`name_a` may not be `null`."
  }
}

variable "name_b" {
  description = "The name to use for bucket B."
  type        = string
  validation {
    condition     = var.name_b != null
    error_message = "`name_b` may not be `null`."
  }
}

variable "mfa_delete_enabled_a" {
  description = "Whether MFA Delete should be enabled for the bucket A."
  type        = bool
  default     = false
}
locals {
  mfa_delete_enabled_a = var.mfa_delete_enabled_a != null ? var.mfa_delete_enabled_a : false
}
variable "mfa_delete_enabled_b" {
  description = "Whether MFA Delete should be enabled for the bucket B. If not provided, will default to the value of `mfa_delete_enabled_a`."
  type        = bool
  default     = null
}
locals {
  mfa_delete_enabled_b = var.mfa_delete_enabled_b != null ? var.mfa_delete_enabled_b : var.mfa_delete_enabled_a
}

variable "bucket_policy_json_documents_a" {
  description = "A list of JSON-encoded policy documents to apply to bucket A. The placeholder \"{BUCKET_ARN}\" can be used to reference the ARN of the bucket the policy is being applied to."
  type        = list(string)
  default     = []
}
locals {
  bucket_policy_json_documents_a = var.bucket_policy_json_documents_a != null ? var.bucket_policy_json_documents_a : []
}

variable "bucket_policy_json_documents_b" {
  description = "A list of JSON-encoded policy documents to apply to bucket B. The placeholder \"{BUCKET_ARN}\" can be used to reference the ARN of the bucket the policy is being applied to."
  type        = list(string)
  default     = []
}
locals {
  bucket_policy_json_documents_b = var.bucket_policy_json_documents_b != null ? var.bucket_policy_json_documents_b : []
}

variable "bucket_policy_json_documents_both" {
  description = "A list of JSON-encoded policy documents to apply to both buckets. The placeholder \"{BUCKET_ARN}\" can be used to reference the ARN of the bucket the policy is being applied to."
  type        = list(string)
  default     = []
}
locals {
  bucket_policy_json_documents_both = var.bucket_policy_json_documents_both != null ? var.bucket_policy_json_documents_both : []
}

variable "kms_key_arn_a" {
  description = "The ARN of the KMS key to use for bucket A. If not provided, AES256 encryption will be enforced instead, unless `create_new_kms_key_a` is set to `true`."
  type        = string
  default     = null
}

variable "kms_key_arn_b" {
  description = "The ARN of the KMS key to use for bucket B. If not provided, AES256 encryption will be enforced instead, unless `create_new_kms_key_b` is set to `true`."
  type        = string
  default     = null
}

variable "create_new_kms_key_a" {
  description = "Whether to create a new KMS key for use with bucket A. If `kms_key_arn_a` is not provided (null), a new key will be created. If `kms_key_arn_a` is provided, a replica of that key will be created."
  type        = bool
  default     = false
}
locals {
  create_new_kms_key_a = var.create_new_kms_key_a != null ? var.create_new_kms_key_a : false
}

variable "create_new_kms_key_b" {
  description = "Whether to create a new KMS key for use with bucket B. If `kms_key_arn_b` is not provided (null), a new key will be created. If `kms_key_arn_b` is provided, a replica of that key will be created."
  type        = bool
  default     = false
}
locals {
  create_new_kms_key_b = var.create_new_kms_key_b != null ? var.create_new_kms_key_b : false
}

variable "create_replica_kms_key_a" {
  description = "Whether to create a replica of the `kms_key_arn_a` key for use with bucket A, if `kms_key_arn_a` was provided."
  type        = bool
  default     = false
}
locals {
  create_replica_kms_key_a = var.create_replica_kms_key_a != null ? var.create_replica_kms_key_a : false
}
variable "create_replica_kms_key_b" {
  description = "Whether to create a replica of the `kms_key_arn_b` key for use with bucket B, if `kms_key_arn_b` was provided."
  type        = bool
  default     = false
}
locals {
  create_replica_kms_key_b = var.create_replica_kms_key_b != null ? var.create_replica_kms_key_b : false
}

variable "kms_key_policy_json_documents_a" {
  description = "A list of JSON-encoded policy documents to apply to the KMS key created for bucket A, if one should be created."
  type        = list(string)
  default     = []
}
locals {
  kms_key_policy_json_documents_a = var.kms_key_policy_json_documents_a != null ? var.kms_key_policy_json_documents_a : []
}

variable "kms_key_policy_json_documents_b" {
  description = "A list of JSON-encoded policy documents to apply to the KMS key created for bucket B, if one should be created."
  type        = list(string)
  default     = []
}
locals {
  kms_key_policy_json_documents_b = var.kms_key_policy_json_documents_b != null ? var.kms_key_policy_json_documents_b : []
}

variable "kms_key_policy_json_documents_both" {
  description = "A list of JSON-encoded policy documents to apply to the KMS keys created for each bucket, if a KMS key was created."
  type        = list(string)
  default     = []
}
locals {
  kms_key_policy_json_documents_both = var.kms_key_policy_json_documents_both != null ? var.kms_key_policy_json_documents_both : []
}

variable "enable_transfer_acceleration_a" {
  description = "Whether to enable transfer acceleration for bucket A."
  type        = bool
  default     = false
}
locals {
  enable_transfer_acceleration_a = var.enable_transfer_acceleration_a != null ? var.enable_transfer_acceleration_a : false
}
variable "enable_transfer_acceleration_b" {
  description = "Whether to enable transfer acceleration for bucket B. If not provided, will default to the value of `enable_transfer_acceleration_a`."
  type        = bool
  default     = null
}
locals {
  enable_transfer_acceleration_b = var.enable_transfer_acceleration_b != null ? var.enable_transfer_acceleration_b : local.enable_transfer_acceleration_a
}

variable "block_public_acls_a" {
  description = "The `block_public_acls` value of an `aws_s3_bucket_public_access_block` resource that is applied to bucket A."
  type        = bool
  default     = true
}
locals {
  block_public_acls_a = var.block_public_acls_a != null ? var.block_public_acls_a : true
}
variable "block_public_acls_b" {
  description = "The `block_public_acls` value of an `aws_s3_bucket_public_access_block` resource that is applied to bucket B. If not provided, will default to the value of `enable_transfer_acceleration_a`."
  type        = bool
  default     = null
}
locals {
  block_public_acls_b = var.block_public_acls_b != null ? var.block_public_acls_b : local.block_public_acls_a
}

variable "block_public_policy_a" {
  description = "The `block_public_policy` value of an `aws_s3_bucket_public_access_block` resource that is applied to bucket A."
  type        = bool
  default     = true
}
locals {
  block_public_policy_a = var.block_public_policy_a != null ? var.block_public_policy_a : true
}
variable "block_public_policy_b" {
  description = "The `block_public_policy` value of an `aws_s3_bucket_public_access_block` resource that is applied to bucket B. If not provided, will default to the value of `block_public_policy_a`."
  type        = bool
  default     = null
}
locals {
  block_public_policy_b = var.block_public_policy_b != null ? var.block_public_policy_b : local.block_public_policy_a
}

variable "ignore_public_acls_a" {
  description = "The `ignore_public_acls` value of an `aws_s3_bucket_public_access_block` resource that is applied to bucket A."
  type        = bool
  default     = true
}
locals {
  ignore_public_acls_a = var.ignore_public_acls_a != null ? var.ignore_public_acls_a : true
}
variable "ignore_public_acls_b" {
  description = "The `ignore_public_acls` value of an `aws_s3_bucket_public_access_block` resource that is applied to bucket B. If not provided, will default to the value of `block_public_policy_a`."
  type        = bool
  default     = null
}
locals {
  ignore_public_acls_b = var.ignore_public_acls_b != null ? var.ignore_public_acls_b : local.ignore_public_acls_a
}

variable "restrict_public_buckets_a" {
  description = "The `restrict_public_buckets` value of an `aws_s3_bucket_public_access_block` resource that is applied to bucket A."
  type        = bool
  default     = true
}
locals {
  restrict_public_buckets_a = var.restrict_public_buckets_a != null ? var.restrict_public_buckets_a : true
}
variable "restrict_public_buckets_b" {
  description = "The `restrict_public_buckets` value of an `aws_s3_bucket_public_access_block` resource that is applied to bucket B. If not provided, will default to the value of `restrict_public_buckets_a`."
  type        = bool
  default     = null
}
locals {
  restrict_public_buckets_b = var.restrict_public_buckets_b != null ? var.restrict_public_buckets_b : local.restrict_public_buckets_a
}

variable "object_ownership_a" {
  description = "The `rule.object_ownership` value of an `aws_s3_bucket_ownership_controls` resource that is applied to bucket A."
  type        = string
  default     = "BucketOwnerEnforced"
}
locals {
  object_ownership_a = var.object_ownership_a != null ? var.object_ownership_a : "BucketOwnerEnforced"
}
variable "object_ownership_b" {
  description = "The `rule.object_ownership` value of an `aws_s3_bucket_ownership_controls` resource that is applied to bucket B. If not provided, will default to the value of `object_ownership_a`."
  type        = string
  default     = null
}
locals {
  object_ownership_b = var.object_ownership_b != null ? var.object_ownership_b : local.object_ownership_a
}

variable "append_region_suffix_a" {
  description = "If `true`, a suffix in the form of `-{region_name}` will be appended to the name of bucket A. This is convenient if you're creating buckets in multiple regions and don't want to manually specify the region name in each one for uniqueness."
  type        = bool
  default     = false
}
locals {
  append_region_suffix_a = var.append_region_suffix_a != null ? var.append_region_suffix_a : false
}
variable "append_region_suffix_b" {
  description = "If `true`, a suffix in the form of `-{region_name}` will be appended to the name of bucket B. This is convenient if you're creating buckets in multiple regions and don't want to manually specify the region name in each one for uniqueness. If not provided, will default to the value of `append_region_suffix_a`."
  type        = bool
  default     = null
}
locals {
  append_region_suffix_b = var.append_region_suffix_b != null ? var.append_region_suffix_b : local.append_region_suffix_a
}

variable "object_lock_enabled_a" {
  description = "Whether to enable Object Lock for bucket A."
  type        = bool
  default     = false
}
locals {
  object_lock_enabled_a = var.object_lock_enabled_a != null ? var.object_lock_enabled_a : false
}
variable "object_lock_enabled_b" {
  description = "Whether to enable Object Lock for bucket B. If not provided, will default to the value of `object_lock_enabled_a`."
  type        = bool
  default     = false
}
locals {
  object_lock_enabled_b = var.object_lock_enabled_b != null ? var.object_lock_enabled_b : local.object_lock_enabled_a
}

variable "force_destroy_a" {
  description = "Whether all objects (including any locked objects) should be deleted from bucket A so that the bucket can be destroyed without error."
  type        = bool
  default     = false
}
locals {
  force_destroy_a = var.force_destroy_a != null ? var.force_destroy_a : false
}
variable "force_destroy_b" {
  description = "Whether all objects (including any locked objects) should be deleted from bucket B so that the bucket can be destroyed without error. If not provided, will default to the value of `force_destroy_a`."
  type        = bool
  default     = null
}
locals {
  force_destroy_b = var.force_destroy_b != null ? var.force_destroy_b : local.force_destroy_a
}

variable "force_allow_cloudtrail_digest_a" {
  description = "Whether to allow AES256 (AWS-managed key) encryption for paths checked by CloudTrail digest writers for bucket A. Even when a bucket and a CloudTrail are both set to use KMS encryption, digests are still written using AWS-managed key AES256 encryption (). This variable only has an effect when the `kms_key_id` variable is provided and not `null`."
  type        = bool
  default     = false
}
locals {
  force_allow_cloudtrail_digest_a = var.force_allow_cloudtrail_digest_a != null ? var.force_allow_cloudtrail_digest_a : false
}
variable "force_allow_cloudtrail_digest_b" {
  description = "Whether to allow AES256 (AWS-managed key) encryption for paths checked by CloudTrail digest writers for bucket B. Even when a bucket and a CloudTrail are both set to use KMS encryption, digests are still written using AWS-managed key AES256 encryption (). This variable only has an effect when the `kms_key_id` variable is provided and not `null`. If not provided, will default to the value of `force_allow_cloudtrail_digest_a`."
  type        = bool
  default     = null
}
locals {
  force_allow_cloudtrail_digest_b = var.force_allow_cloudtrail_digest_b != null ? var.force_allow_cloudtrail_digest_b : local.force_allow_cloudtrail_digest_a
}

variable "replicate_a_to_b" {
  description = "Whether to replicate objects from bucket A to bucket B."
  type        = bool
  validation {
    condition     = var.replicate_a_to_b != null
    error_message = "`replicate_a_to_b` may not be `null`."
  }
}

variable "replicate_b_to_a" {
  description = "Whether to replicate objects from bucket B to bucket A."
  type        = bool
  validation {
    condition     = var.replicate_b_to_a != null
    error_message = "`replicate_b_to_a` may not be `null`."
  }
}

variable "a_to_b_rules" {
  description = "A list of rules for replicating objects from bucket A to bucket B, ordered by descending priority. If none are provided, it will default to replicating everything, including delete markers and replica modifications."
  type = list(object({
    id                          = string
    delete_marker_replication   = bool
    existing_object_replication = bool
    replica_modifications       = bool
    prefix                      = string
    tags                        = map(string)
    replication_time            = number
    event_threshold             = number
    storage_class               = string
  }))
  default = []
}

variable "b_to_a_rules" {
  description = "A list of rules for replicating objects from bucket B to bucket A, ordered by descending priority. If none are provided, it will default to replicating everything, including delete markers and replica modifications."
  type = list(object({
    id                          = string
    delete_marker_replication   = bool
    existing_object_replication = bool
    replica_modifications       = bool
    prefix                      = string
    tags                        = map(string)
    replication_time            = number
    event_threshold             = number
    storage_class               = string
  }))
  default = []
}

locals {
  a_to_b_rules = var.a_to_b_rules != null ? var.a_to_b_rules : []
  b_to_a_rules = var.b_to_a_rules != null ? var.b_to_a_rules : []
}

variable "tags" {
  description = "Tags to apply to S3 bucket created in this module."
  type        = map(string)
  default     = {}
}
