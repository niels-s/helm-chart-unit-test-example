{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "web.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "web.labels" -}}
helm.sh/chart: {{ include "web.chart" . | quote }}
{{ include "web.selectorLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "web.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name | quote }}
app.kubernetes.io/component: "web"
{{- end -}}
