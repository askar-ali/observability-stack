variable "oncall_email" {
  description = "Email of the on-call user."
  type        = string
  default     = "oncall@example.com"
}

variable "service_name" {
  type    = string
  default = "platform-prod"
}

variable "cpu_threshold" {
  type    = number
  default = 85
}
