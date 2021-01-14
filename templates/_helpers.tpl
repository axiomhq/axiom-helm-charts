{{/*
Expand the name of the chart.
*/}}
{{- define "axiom.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "axiom.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "axiom.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "axiom.labels" -}}
helm.sh/chart: {{ include "axiom.chart" . }}
{{ include "axiom.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "axiom.selectorLabels" -}}
app.kubernetes.io/name: {{ include "axiom.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Docker registry configuration
*/}}
{{- define "axiomImagePullSecret" }}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"email\":\"%s\",\"auth\":\"%s\"}}}" "https://index.docker.io/v1/" "axiomcust" .Values.registryAccessToken "not@val.id" (printf "%s:%s" "axiomcust" .Values.registryAccessToken | b64enc) | b64enc }}
{{- end }}

{{/*
Build storage URI
*/}}
{{- define "axiomStorageURI" }}
{{- $storageUrl := urlParse .uri }}
{{- $provider := get $storageUrl "scheme" }}
{{- $bucket := get $storageUrl "host" | required "Missing bucket/container name in storage URI" }}
{{- if eq $provider "s3" }}
  {{- $keyId := .awsAccessKeyID | required "Missing AWS access key ID" | urlquery }}
  {{- $secret := .awsSecretAccessKey | required "Missing AWS secret access key" | urlquery }}
  {{- $region := .awsRegion | required "Missing AWS region" | urlquery }}
  {{- $query := cat "access_key=" $keyId "&secret_key=" $secret "&region=" $region | nospace }}
  {{- $_ := set $storageUrl "query" $query }}
{{- else if eq $provider "blob" }}
  {{- $account := .azureStorageAccount | required "Missing Azure storage account" | urlquery }}
  {{- $secret := .azureStorageAccessKey | required "Missing Azure storage access key" | urlquery }}
  {{- $query := cat "storage_account=" $account "&access_key=" $secret | nospace }}
  {{- $_ := set $storageUrl "query" $query }}
{{- else if eq $provider "spaces" }}
  {{- $keyId := .spacesKey | required "Missing Spaces key" | urlquery }}
  {{- $secret := .spacesSecret | required "Missing Spaces secret" | urlquery }}
  {{- $region := .spacesRegion | required "Missing Spaces region" | urlquery }}
  {{- $query := cat "key=" $keyId "&secret=" $secret "&region=" $region | nospace }}
  {{- $_ := set $storageUrl "query" $query }}
{{- else if eq $provider "gcs" }}
  {{- $credentials := required "Missing Google credentials JSON" .googleApplicationCredentials | b64enc | urlquery }}
  {{- $query := cat "credentials=" $credentials | nospace }}
  {{- $_ := set $storageUrl "query" $query }}
{{- else }}
  {{- required "Invalid URI" ""}}
{{- end }}
{{- urlJoin $storageUrl | b64enc | quote }}
{{- end }}
