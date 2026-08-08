resource "datadog_service_level_objective" "availability" {
  name        = "${var.service_name} availability"
  type        = "metric"
  description = "Share of requests that do not return 5xx"

  query {
    numerator   = "sum:trace.http.request.hits{env:prod,service:${var.service_name}}.as_count() - sum:trace.http.request.errors{env:prod,service:${var.service_name}}.as_count()"
    denominator = "sum:trace.http.request.hits{env:prod,service:${var.service_name}}.as_count()"
  }

  thresholds {
    timeframe = "30d"
    target    = var.slo_target
    warning   = var.slo_target + 0.05
  }

  tags = ["service:${var.service_name}", "managed-by:terraform"]
}
