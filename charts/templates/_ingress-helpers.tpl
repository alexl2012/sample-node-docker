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