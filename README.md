# axiom-helm-chart

# Installation Instructions

You can install the Axiom Helm chart using the following command
```
$ helm repo add axiom https://axiomhq.github.io/axiom-helm-charts
$ helm repo update
$ helm upgrade -i -f ./values.yaml axiom axiom/axiom -n <namespace>
```

# Values


See [Runing Axiom on Kubernetes](https://www.axiom.co/docs/install/kubernetes)
for usage instructions.

## How to update a new version

Update `version` and `appVersion` in `Chart.yaml`, then run these commands:

```shell
helm package .
mv axiom-$version.tgz docs/
helm repo index docs/ --url 'https://axiomhq.github.io/axiom-helm-charts'
```
