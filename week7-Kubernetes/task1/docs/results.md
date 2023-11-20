### TLS certificate
The applicatioin accessable by the defined domain name and has valid TLS ceretificate issuied by Let's Encrypt:
![](docs/2023-11-20_02h16_10.png)

### Autoscaling
I ran load test with Locust which proves the HPA works:

`kubectl describe deployment sample-app`
![](docs/2023-11-20_02h38_51.png)

Locus diagram:
![](docs/2023-11-20_02h36_44.png)

