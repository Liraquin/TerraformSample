#If FIFO
/* resource "aws_sns_topic" "tfsnsfifo" {
    for_each                    = var.topicNamefifo
    name                        = each.key
    fifo_topic                  = true
    content_based_deduplication = true
    kms_master_key_id = "alias/aws/sns"
} */

# if not FIFO
resource "aws_sns_topic" "tfsns" {
    for_each                    = var.topicName
    name                        = each.key
    kms_master_key_id = "alias/aws/sns"
}

# adding current topic to bucket notifications

resource "aws_s3_bucket_notification" "bucket_notification" {
  for_each = aws_s3_bucket.tfbucket
  bucket = each.key
  topic {
    topic_arn     = aws_sns_topic.topic.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".log"
  }
  depends_on = [
    aws_s3_bucket_public_access_block.bucketPolicy,
  ]
}