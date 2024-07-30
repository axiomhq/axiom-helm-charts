This helm chart represents a new deprecated version of Axiom previously relevant for a handful of self-hosted customers. Axiom now offers Virtual Private Axiom to fulfill this usecase. This chart should not be assumed to represent a data collector for use with Axiom. See our [documentation](https://www.axiom.co/docs/) for more details.

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
