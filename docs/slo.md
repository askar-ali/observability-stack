# SLO approach

- **SLI**: fraction of requests not returning 5xx.
- **Target**: 99.9% over 30 days = 43 minutes of budget.
- **Alerting**: burn-rate alerts (`prometheus/rules/slo-alerts.yml`) rather than raw error rate:
  fast burn (14.4x over 1h and 5m) pages; slow burn should open a ticket.
- **Datadog**: `terraform/slo.tf` mirrors the same SLO for dashboards and reporting.
- When the budget is spent, reliability work takes priority over feature work.
