## Scenario:
You are a pert of a large IT company that wishes to use the power of Kubernetes for their container orchestration. The company has a new application that needs to be deployed and managed in the cloud. This is a simple Django application which connects to a database. The company wants to use Helm for deploying the application, as it is the most popular package manager for Kubernetes.

## Tasks:
1. Deploy a Kubernetes cluster in DigitalOcean cloud
1. Create a Helm chart for the application, which should include the following:
   - ConfigMap for environment variables.
   - Secret for secret environment variables (such as database password). Secrets should be encrypted using any method available for Kubernetes (for instance, helm-secrets).
   - Deployment configuration that:
     - Runs two replicas of the application.
     - Operates on port 8080
     - Propagates ConfigMap and Secret to the container
     - Has readiness and liveness probes
     - A Service of type ClusterIP
     - An Ingress controller for AWS or Digital Ocean, depending on the provider, which will elevate the corresponding LB
     - A CertManager, which will obtain a Let's Encrypt certificate
     - A HorizontalPodAutoscaler, which will scale the replicas from 2 to 4 depending on the CPU or RAM usage at 80%
1. Prepare a helmfile for deploying the environment
