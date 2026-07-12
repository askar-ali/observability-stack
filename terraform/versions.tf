terraform {
  required_version = ">= 1.6.0"
  required_providers {
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.43"
    }
    pagerduty = {
      source  = "PagerDuty/pagerduty"
      version = "~> 3.14"
    }
  }
}

# Credentials from env: DD_API_KEY, DD_APP_KEY, PAGERDUTY_TOKEN.
provider "datadog" {}
provider "pagerduty" {}
