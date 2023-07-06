# Role to be used by Backup service
resource "aws_iam_role" "backup" {
  name               = "${var.name_prefix}-backup-role${local.name_suffix}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_backup.json
}

data "aws_iam_policy_document" "assume_role_backup" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"
      identifiers = [
        "backup.amazonaws.com"
      ]
    }
  }
}

# Role policy to be attached to the Backup service role
data "aws_iam_policy" "backup" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role_policy_attachment" "backup" {
  role       = "${aws_iam_role.backup.name}"
  policy_arn = "${data.aws_iam_policy.backup.arn}"
}

# Backup Vault
resource "aws_backup_vault" "a_backup_vault" {
  name        = "${var.name_prefix}-backup-vault${local.name_suffix}"
}

# Backup Plan for nightly backup at 12:00 AM PST (-7 UTC)
resource "aws_backup_plan" "a_backup_plan" {
  name = "${var.name_prefix}-backup-plan${local.name_suffix}"

  rule {
    rule_name         = "${var.name_prefix}-backup-rule${local.name_suffix}"
    target_vault_name = aws_backup_vault.a_backup_vault.name
    schedule          = "cron(0 7 ? * * *)"

    completion_window = 360

    lifecycle {
      delete_after = 30
    }
  }
}
# Selection to Backup based off Tags
resource "aws_backup_selection" "a_backup_selection" {
  iam_role_arn = aws_iam_role.backup.arn
  name         = "${var.name_prefix}-backup-selection${local.name_suffix}"
  plan_id      = aws_backup_plan.a_backup_plan.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = var.backup_key
    value = var.backup_key_value
  }
}

resource "aws_backup_vault_notifications" "backup_failed" {
  backup_vault_name   = aws_backup_vault.a_backup_vault.name
  sns_topic_arn       = aws_sns_topic.backup_failed.arn
  backup_vault_events = ["BACKUP_JOB_FAILED"]
}

# SNS resources for failed nightly Backups
resource "aws_sns_topic" "backup_failed" {
  name = "${var.name_prefix}-backup-failed${local.name_suffix}"
}

resource "aws_sns_topic_subscription" "backup_failed" {
  topic_arn = aws_sns_topic.backup_failed.arn
  protocol  = "email"
  endpoint  = var.backup_failed_sns_endpoint
}

resource "aws_sns_topic_policy" "test" {
  arn    = aws_sns_topic.backup_failed.arn
  policy = data.aws_iam_policy_document.backup_sns.json
}

data "aws_iam_policy_document" "backup_sns" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Publish",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.backup_failed.arn,
    ]
  }
}