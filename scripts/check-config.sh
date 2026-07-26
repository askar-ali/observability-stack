#!/usr/bin/env bash
# Validate Prometheus config, rules and rule unit tests with promtool.
set -euo pipefail
cd "$(dirname "$0")/.."
command -v promtool >/dev/null || { echo "promtool required" >&2; exit 1; }

promtool check config prometheus/prometheus.yml
promtool check rules prometheus/rules/*.yml
promtool test rules prometheus/tests/*.yml
