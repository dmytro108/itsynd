{{- define "db-credentials.secret" -}}
kind: Secret
apiVersion: v1

metadata:
  name: db-credentials
  namespace: {{ .Release.Name }}

type: Opaque
stringData:
  POSTGRES_USER: {{ .Values.postgresUser }}
  POSTGRES_PASSWORD: {{ .Values.postgresPassword }}
{{- end -}}