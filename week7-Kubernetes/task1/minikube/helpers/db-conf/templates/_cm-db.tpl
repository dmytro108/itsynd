{{- define "db-config.cm" -}}
kind: ConfigMap
apiVersion: v1

metadata:
  name: db-config
  namespace: {{ .Release.Name }}

data:
  POSTGRES_DB:    {{ .Values.DB.Name   | quote }}
  POSTGRES_PORT:  {{ .Values.DB.Port   | quote }}
  POSTGRES_HOST:  {{ .Values.DB.Host   | quote }}
  DB_SCHEMA:      {{ .Values.DB.Schema | quote }}
{{- end -}}