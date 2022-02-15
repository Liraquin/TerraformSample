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