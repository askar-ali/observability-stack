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

variable "slo_target" {
  description = "Availability target in percent."
  type        = number
  default     = 99.9

  validation {
    condition     = var.slo_target > 90 && var.slo_target < 100
    error_message = "slo_target must be between 90 and 100 (exclusive)."
  }
}

variable "oncall_time_zone" {
  type    = string
  default = "Asia/Kolkata"
}
