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

---

kind: Role
apiVersion: rbac.authorization.k8s.io/v1

metadata:
  name: db-credentials-reeader
  namespace: {{ .Release.Name }}

rules:
- apiGroups: [""] 
  resources: ["secrets"]
  resourceNames: ["db-credentials"]
  verbs: ["get"] 

{{- end -}}