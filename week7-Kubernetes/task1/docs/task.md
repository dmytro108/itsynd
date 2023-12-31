1. [x] Deploy a Kubernetes cluster in either DigitalOcean or AWS
1. [x] Create a Helm chart for the application, which should include the following:
   - [x] ConfigMap for environment variables.
   - [x] Secret for secret environment variables (such as database password). Secrets should be encrypted using any method available for Kubernetes (for instance, helm-secrets).
   - [x] Deployment configuration that:
     - [x] Runs two replicas of the application.
     - [x] Operates on port 8080
     - [x] Propagates ConfigMap and Secret to the container
     - [x] Has readiness and liveness probes
     - [x] A Service of type ClusterIP
     - [x] An Ingress controller for AWS or Digital Ocean, depending on the provider, which will elevate the corresponding LB
     - [x] A CertManager, which will obtain a Let's Encrypt certificate
     - [x] A HorizontalPodAutoscaler, which will scale the replicas from 2 to 4 depending on the CPU or RAM usage at 80%
1. [x] Prepare a helmfile for deploying the environment
