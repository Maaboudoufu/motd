variable "port" {
  type        = number
  description = "host port for web server"
  default     = 8080
}

variable "timezone" {
  type        = string
  description = "sets timezone"
  default     = "America/Los_Angeles"

}
