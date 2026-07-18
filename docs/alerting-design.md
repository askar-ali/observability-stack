# Alerting design

- Page only on symptoms that need a human now (`critical`); warnings go to a channel.
- Alertmanager groups by alertname+instance and inhibits warnings while a critical fires.
- Datadog monitors notify the PagerDuty service via the `@pagerduty-<service>` handle;
  escalation policy re-notifies after 10 minutes.
- Review monthly: delete or tune any alert that fired without action.
