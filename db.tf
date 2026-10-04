resource "docker_image" "mysql" {
  name = "mysql:8.4"
}

resource "docker_container" "db" {
  name  = "motd-db"
  image = docker_image.mysql.image_id


  env = [
    "MYSQL_RANDOM_ROOT_PASSWORD=yes",
    "MYSQL_DATABASE=motd",
    "MYSQL_USER=motd",
    "MYSQL_PASSWORD=${random_password.db.result}",
  ]


  networks_advanced {
    name    = docker_network.motd.name
    aliases = ["db"]
  }

  volumes {
    volume_name    = docker_volume.db_data.name
    container_path = "/var/lib/mysql"
  }

  volumes {
    host_path      = abspath("${path.module}/seed")
    container_path = "/docker-entrypoint-initdb.d"
    read_only      = true
  }

  healthcheck {
    test     = ["CMD", "mysqladmin", "ping", "-h", "127.0.0.1", "--silent"]
    interval = "5s"
    timeout  = "3s"
    retries  = 3
  }
  wait         = true
  wait_timeout = 180
}
