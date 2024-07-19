resource "aws_efs_file_system" "factorio" {}

resource "aws_efs_mount_target" "factorio" {
  file_system_id  = aws_efs_file_system.factorio.id
  security_groups = [aws_security_group.factorio-efs.id]
  subnet_id       = aws_default_subnet.default_subnet_a.id
}

resource "aws_efs_backup_policy" "factorio" {
  file_system_id = aws_efs_file_system.factorio.id

  backup_policy {
    status = "ENABLED"
  }
}
