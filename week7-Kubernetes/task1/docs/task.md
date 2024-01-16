## Scenario:
You are a part of a large IT company that wishes to use the power of Kubernetes for their container orchestration. The company has a new web application that needs to be deployed and managed in the cloud. 

It seamlessly combines dynamic and static content. The dynamic part of the application is built using the Django web framework which relies on a PostgreSQL database. To enhance security, the web application should be equipped with a TLS certificate from Let's Encrypt, ensuring that all data exchanged between the server and users is encrypted and secure.

Ensuring uninterrupted service during periods of high user demand is a critical concern for the business. 

The company wants to use Helm for deploying the application, as it is the most popular package manager for Kubernetes.

## Tasks:
1. Deploy a Kubernetes cluster in DigitalOcean cloud
1. Create a Helm chart for the application, which should include the following:
    1. ConfigMap for environment variables.
    1.  Secret for secret environment variables (such as database password). Secrets should be encrypted using any method available for Kubernetes (for instance, helm-secrets).
    1.  Deployment configuration that:
        - Runs two replicas of the application.
        - Operates on port 8080
        - Propagates ConfigMap and Secret to the container
        - Has readiness and liveness probes
    1. A Service of type ClusterIP
    1. An Ingress controller for Digital Ocean which will elevate the corresponding LB
    1. A CertManager, which will obtain a Let's Encrypt certificate
    1. A HorizontalPodAutoscaler, which will scale the replicas from 2 to 4 depending on the CPU or RAM usage at 80%
    1. Create and attach a persisent storrage to store the static web content.
2. Prepare a helmfile for deploying the environment
