resource "aws_connect_instance_storage_config" "connect_instance_storage_configs" {
  for_each = var.connect_instance_storage_configs

  instance_id   = each.value.instance_id
  resource_type = each.value.resource_type
  region        = each.value.region

  storage_config {
    dynamic "kinesis_firehose_config" {
      for_each = each.value.storage_config.kinesis_firehose_config != null ? [each.value.storage_config.kinesis_firehose_config] : []
      content {
        firehose_arn = kinesis_firehose_config.value.firehose_arn
      }
    }
    dynamic "kinesis_stream_config" {
      for_each = each.value.storage_config.kinesis_stream_config != null ? [each.value.storage_config.kinesis_stream_config] : []
      content {
        stream_arn = kinesis_stream_config.value.stream_arn
      }
    }
    dynamic "kinesis_video_stream_config" {
      for_each = each.value.storage_config.kinesis_video_stream_config != null ? [each.value.storage_config.kinesis_video_stream_config] : []
      content {
        encryption_config {
          encryption_type = kinesis_video_stream_config.value.encryption_config.encryption_type
          key_id          = kinesis_video_stream_config.value.encryption_config.key_id
        }
        prefix                 = kinesis_video_stream_config.value.prefix
        retention_period_hours = kinesis_video_stream_config.value.retention_period_hours
      }
    }
    dynamic "s3_config" {
      for_each = each.value.storage_config.s3_config != null ? [each.value.storage_config.s3_config] : []
      content {
        bucket_name   = s3_config.value.bucket_name
        bucket_prefix = s3_config.value.bucket_prefix
        dynamic "encryption_config" {
          for_each = s3_config.value.encryption_config != null ? [s3_config.value.encryption_config] : []
          content {
            encryption_type = encryption_config.value.encryption_type
            key_id          = encryption_config.value.key_id
          }
        }
      }
    }
    storage_type = each.value.storage_config.storage_type
  }
}

