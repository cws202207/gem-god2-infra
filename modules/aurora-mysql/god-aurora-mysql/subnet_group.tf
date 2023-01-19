# ------------------
# Subnet Group
# ------------------
resource "aws_db_subnet_group" "private" {
  name       = "${var.name}-private"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "Private DB Subnet group"
  }
}
