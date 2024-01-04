{{- define "default-deny.npol" -}}
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1

metadata:
  namespace: {{ .Release.Name }}
  name: default-deny

spec:
  policyTypes:
  - Ingress
  - Egress
  podSelector: {}

{{- end -}}