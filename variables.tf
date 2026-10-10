variable "connect_instance_storage_configs" {
  description = <<EOT
Map of connect_instance_storage_configs, attributes below
Required:
    - instance_id
    - resource_type
    - storage_config (block):
        - kinesis_firehose_config (optional, block):
            - firehose_arn (required)
        - kinesis_stream_config (optional, block):
            - stream_arn (required)
        - kinesis_video_stream_config (optional, block):
            - encryption_config (required, block):
                - encryption_type (required)
                - key_id (required)
            - prefix (required)
            - retention_period_hours (required)
        - s3_config (optional, block):
            - bucket_name (required)
            - bucket_prefix (required)
            - encryption_config (optional, block):
                - encryption_type (required)
                - key_id (required)
        - storage_type (required)
Optional:
    - region
EOT

  type = map(object({
    instance_id   = string
    resource_type = string
    region        = optional(string)
    storage_config = object({
      kinesis_firehose_config = optional(object({
        firehose_arn = string
      }))
      kinesis_stream_config = optional(object({
        stream_arn = string
      }))
      kinesis_video_stream_config = optional(object({
        encryption_config = object({
          encryption_type = string
          key_id          = string
        })
        prefix                 = string
        retention_period_hours = number
      }))
      s3_config = optional(object({
        bucket_name   = string
        bucket_prefix = string
        encryption_config = optional(object({
          encryption_type = string
          key_id          = string
        }))
      }))
      storage_type = string
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.connect_instance_storage_configs : (
        v.storage_config.kinesis_video_stream_config == null || (v.storage_config.kinesis_video_stream_config.retention_period_hours >= 0 && v.storage_config.kinesis_video_stream_config.retention_period_hours <= 87600)
      )
    ])
    error_message = "must be between 0 and 87600"
  }
  # Note: 12 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

