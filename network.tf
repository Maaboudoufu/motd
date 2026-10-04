resource "docker_network" "motd" {
  name = "motd"
}

resource "docker_volume" "db_data" {
  name = "motd-db-data"
}
