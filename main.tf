locals {
  username = "${var.database_name}_user"
  db_name = "${var.database_name}_db"
}

resource "random_password" "database_password" {
  length           = 32
  special          = true
  override_special = "_%@"
}

resource "postgresql_role" "my_role" {
  name     = local.username
  login    = true
  password = random_password.database_password.result
}

resource "postgresql_grant_role" "additional_users" {
  for_each = { for user in var.additional_users : user => user }
  role       = each.value
  grant_role = postgresql_role.my_role.name
}

resource "postgresql_database" "my_db" {
  name              = local.db_name
  owner             = postgresql_role.my_role.name
}