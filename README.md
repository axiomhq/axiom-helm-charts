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
