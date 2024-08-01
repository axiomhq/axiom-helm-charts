This Helm chart provides a deprecated version of Axiom, previously used by a limited number of self-hosted customers. Axiom now offers Virtual Private Axiom to fulfill this use case. This chart should not be assumed to represent a data collector for use with Axiom. For more details about sending data to Axiom, please refer to our [documentation](https://www.axiom.co/docs/).

# axiom-helm-chart

See [Runing Axiom on Kubernetes](https://www.axiom.co/docs/install/kubernetes)
for usage instructions.

## How to update a new version

Update `version` and `appVersion` in `Chart.yaml`, then run these commands:

```shell
helm package .
mv axiom-$version.tgz docs/
helm repo index docs/ --url 'https://axiomhq.github.io/axiom-helm-charts'
```
