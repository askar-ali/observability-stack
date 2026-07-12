data "pagerduty_user" "oncall" {
  email = var.oncall_email
}

resource "pagerduty_escalation_policy" "platform" {
  name      = "${var.service_name}-escalation"
  num_loops = 2

  rule {
    escalation_delay_in_minutes = 10
    target {
      type = "user_reference"
      id   = data.pagerduty_user.oncall.id
    }
  }
}

resource "pagerduty_service" "platform" {
  name                    = var.service_name
  escalation_policy       = pagerduty_escalation_policy.platform.id
  alert_creation          = "create_alerts_and_incidents"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 1800
}

resource "pagerduty_service_integration" "datadog" {
  name    = "Datadog"
  service = pagerduty_service.platform.id
  vendor  = data.pagerduty_vendor.datadog.id
}

data "pagerduty_vendor" "datadog" {
  name = "Datadog"
}
