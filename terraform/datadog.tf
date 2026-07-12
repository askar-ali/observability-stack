locals {
  notify = "@pagerduty-${pagerduty_service.platform.name}"
}

resource "datadog_monitor" "host_cpu" {
  name    = "[${var.service_name}] High CPU on {{host.name}}"
  type    = "metric alert"
  message = "CPU above ${var.cpu_threshold}% for 10m. ${local.notify}"
  query   = "avg(last_10m):100 - avg:system.cpu.idle{env:prod} by {host} > ${var.cpu_threshold}"

  monitor_thresholds {
    warning  = var.cpu_threshold - 10
    critical = var.cpu_threshold
  }

  notify_no_data    = false
  renotify_interval = 120
  tags              = ["service:${var.service_name}", "managed-by:terraform"]
}

resource "datadog_monitor" "pod_restarts" {
  name    = "[${var.service_name}] Pod restarting frequently"
  type    = "query alert"
  message = "Pod {{pod_name.name}} restarted repeatedly. ${local.notify}"
  query   = "change(avg(last_10m),last_10m):sum:kubernetes.containers.restarts{env:prod} by {pod_name} > 3"

  monitor_thresholds {
    critical = 3
  }

  tags = ["service:${var.service_name}", "managed-by:terraform"]
}

resource "datadog_dashboard" "overview" {
  title       = "${var.service_name} overview"
  layout_type = "ordered"

  widget {
    timeseries_definition {
      title = "CPU by host"
      request {
        q            = "avg:system.cpu.user{env:prod} by {host}"
        display_type = "line"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Container restarts"
      request {
        q            = "sum:kubernetes.containers.restarts{env:prod} by {pod_name}"
        display_type = "bars"
      }
    }
  }
}
