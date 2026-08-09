locals {
  # Additional host monitors defined as data; one resource block creates them all.
  host_monitors = {
    memory = {
      query    = "avg(last_10m):avg:system.mem.pct_usable{env:prod} by {host} < 0.1"
      message  = "Less than 10% memory usable on {{host.name}}."
      critical = 0.1
    }
    disk = {
      query    = "avg(last_15m):avg:system.disk.in_use{env:prod} by {host,device} > 0.9"
      message  = "Disk over 90% on {{host.name}} {{device.name}}."
      critical = 0.9
    }
  }
}

resource "datadog_monitor" "host" {
  for_each = local.host_monitors

  name    = "[${var.service_name}] ${title(each.key)} on {{host.name}}"
  type    = "metric alert"
  message = "${each.value.message} ${local.notify}"
  query   = each.value.query

  monitor_thresholds {
    critical = each.value.critical
  }

  tags = ["service:${var.service_name}", "managed-by:terraform"]
}
