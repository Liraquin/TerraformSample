
# FIFO queue specifics
resource "aws_sqs_queue" "tfsqsfifo" {
    for_each = var.queueNamefifo
    name                        = each.key
    fifo_queue                  = true
    content_based_deduplication = true
    sqs_managed_sse_enabled     = true
}

# If not FIFO
/* resource "aws_sqs_queue" "tfsqs" {
    for_each = var.queueName
    name                        = each.key
    sqs_managed_sse_enabled     = true
} */