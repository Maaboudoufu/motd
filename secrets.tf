resource "random_password" "db" {
  length  = 24
  special = false
}

resource "random_password" "token" {
  length  = 24
  special = false
}
