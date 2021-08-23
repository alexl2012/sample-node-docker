{{- define "lego.ingressAkamaiHosts" }}
{{ if and (eq .Values.deployTimeValues.urlType "STATIC") (eq .Values.deployTimeValues.branchType "release") }}
{{ if eq .Values.envType "prod" }}
{{- range $countryHost := list "www.tesco.com" "azure.tesco.com" "ezakupy.tesco.pl" "nakup.itesco.cz" "potravinydomov.itesco.sk" "bevasarlas.tesco.hu" "shoponline.tescolotus.com" "eshop.tesco.com.my" }}
- host: {{ $countryHost }}
{{ include "webapps-lib.ingressPath" $ | indent 2 }}
{{- end }}
{{- end }}
{{ if eq .Values.envType "ppe" }}
- host: www-ppe.tesco.com
{{ include "webapps-lib.ingressPath" . | indent 2 }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "applicationName" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Values.branchOrBranchType .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}