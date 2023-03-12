resource "aws_kms_key" "this" {
  count                   = var.create_cmk ? 1 : 0

  description             = "${var.project_id}-cmk"
  deletion_window_in_days = var.cmk_deletion_window_in_days
  tags                    = var.tags
}

resource "aws_kms_alias" "this" {
  count                   = var.create_cmk ? 1 : 0

  name                    = "alias/${var.project_id}-cmk"
  target_key_id           = aws_kms_key.this[0].id
}
