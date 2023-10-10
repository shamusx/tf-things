variable "resource_group" {
  type    = string
  default = null
}

variable "admin_user" {
  type        = string
  default = "tsbadmin"
  description = "name prefix"
}

variable "admin_password" {
  type        = string
  default = "Tetrate123"
  description = "name prefix"
}

variable "postgresql_version" {
  type        = string
  description = "name prefix"
  default = "11"
}