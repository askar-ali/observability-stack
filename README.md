# observability-stack

Metrics, dashboards and alert routing:

- **Local stack** (Docker Compose): Prometheus + Alertmanager + Grafana + node-exporter.
- **SaaS as code** (Terraform): Datadog monitors and PagerDuty service/escalation routing.

> Lab recreation of the monitoring setup I use in production (since 10/2025).
> Placeholder keys and emails; secrets come from environment variables.

## Why

| Piece | Reason |
|-------|--------|
| Prometheus + Grafana | Open-source metrics and dashboards, great with Kubernetes |
| Alertmanager | Grouping, inhibition and routing; reduces alert fatigue |
| Datadog (Terraform) | Monitors reviewed in PRs instead of clicked in a UI |
| PagerDuty (Terraform) | On-call routing and escalation reproducible and auditable |

## Run locally

```bash
docker compose up -d
# Grafana http://localhost:3000 (admin / see GF_SECURITY_ADMIN_PASSWORD)
# Prometheus http://localhost:9090   Alertmanager http://localhost:9093
```

## Terraform

```bash
export DD_API_KEY=... DD_APP_KEY=... PAGERDUTY_TOKEN=...
cd terraform && terraform init && terraform plan
```
