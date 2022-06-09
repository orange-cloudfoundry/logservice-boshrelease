# logservice-boshrelease

It's a bosh release for deploying [logs-service-broker](https://github.com/orange-cloudfoundry/logs-service-broker)
and also provide a drop in replacement of parsing app logs and metrics on a [logsearch-boshrelease](https://github.com/cloudfoundry-community/logsearch-boshrelease).
It also includes dashboards for grafana and alerts for prometheus for logs-service-broker.

Logs-service-broker is a broker server for logs parsing (with custom parsing patterns given by user or operator) and 
forwarding to one or multiple syslog endpoint in the [RFC 5424](https://datatracker.ietf.org/doc/rfc5424/) syslog format.
Take care that logs-service-broker will always provide a json encoded format to final syslogs endpoint(s).

It is currently tied to Cloud Foundry for different types of logs received by this platform.

This is compliant with the spec [Open Service Broker API](https://www.openservicebrokerapi.org/) for 
[syslog drain](https://github.com/openservicebrokerapi/servicebroker/blob/master/spec.md#log-drain).

## Deploy for Cloud Foundry with dashboards and alerts on your Prometheus

1. Add ops files [adapter-add-service-certs.yml](/manifests/operations/cf/adapter-add-service-certs.yml) and 
[database-enable-logservice.yml](/manifests/operations/cf/database-enable-logservice.yml) on your Cloud Foundry deployment.
2. Add ops file [monitor-logservice.yml](/manifests/operations/prometheus/monitor-logservice.yml) on your Prometheus deployment.
2. Deploy manifest [logservice.yml](/manifests/logservice.yml).

## Replace logsearch apps parsing by logservice

1. Place runtime-config [logsearch-dns.yml](/manifests/runtime-configs/logsearch-dns.yml) with command:
`bosh update-runtime-config manifests/runtime-configs/logsearch-dns.yml --name=logsearch-dns`.
 This will set a bosh DNS config to know how to hit logstash on logsearch by logservice.
3. Redeploy logservice to know this new bosh-dns entry.
4. Add ops file [add-logservice.yml](/manifests/operations/logsearch/add-logservice.yml) to your logsearch deployment.
