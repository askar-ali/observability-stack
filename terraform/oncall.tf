resource "pagerduty_schedule" "primary" {
  name      = "${var.service_name}-primary"
  time_zone = var.oncall_time_zone

  layer {
    name                         = "Weekly rotation"
    start                        = "2026-01-05T09:00:00+05:30"
    rotation_virtual_start       = "2026-01-05T09:00:00+05:30"
    rotation_turn_length_seconds = 604800
    users                        = [data.pagerduty_user.oncall.id]
  }
}
