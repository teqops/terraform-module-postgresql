variable "database_name" {
}

variable "additional_users" {
  type = list
  default = []
}

output "password" {
    value = random_password.database_password.result  
}

output "name" {
    value = local.db_name
}

output "username" {
    value = local.username
}