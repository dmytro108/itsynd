## Tasks
1. Add 1Gb swap.
2. Configure Nginx to return static files included in index.php from http://its-test-public.s3-website-us-east-1.amazonaws.com/
3. Install a self-signed certificate and configure traffic redirect from HTTP to HTTPS
4. Create an SFTP account with access only to files and site logs.
## Solution
- **Check the [website](https://ec2-44-201-223-102.compute-1.amazonaws.com)**
- **SFTP connection: `itsyndicate@44.201.223.102` Passw: `ITsyndicate45#`**

### Task 1

1. Check the current swap space:
```
sudo swapon --show
```
2. Create a swap file
```
sudo fallocate -l 1G /swapfile1GB
sudo chmod 600 /swapfile1GB
```
3. Configure the file as swap space
```
sudo mkswap /swapfile1GB
sudo swapon /swapfile1GB
```
4. Make the swap file permanent
```
sudo echo '/swapfile1GB none swap sw 0 0' >> /etc/fstab
```

### Task 2

1. Add `location` block into `server` defenition in */etc/nginx/sites-enabled/default*:
```
location /static/ {
  proxy_pass http://its-test-public.s3-website-us-east-1.amazonaws.com/;
}
```
2. Restart NginX
```
sudo nginx -t
sudo service nginx restart
```

### Task 3

1. Generate a self-signed SSL certificate:
```
sudo openssl req -x509 -newkey rsa:2048  -nodes  -days 365 \
-keyout /etc/nginx/ssl/private.key \
-out /etc/nginx/ssl/certificate.crt
```
follow the command's prompt to enter the neccessery data.

2. Add redirection directive into HTTPP `server` block in  */etc/nginx/sites-enabled/default*
```
return 301 https://$host$request_uri;
```
3. Add HTTPS `server` block:
```
server {
  listen 443 ssl;
  server_name ec2-44-201-223-102.compute-1.amazonaws.com;
  ssl_certificate /etc/nginx/ssl/certificate.crt;
  ssl_certificate_key /etc/nginx/ssl/private.key;
# Copy all the rest from HTTP server block
...
}
```
4. Restart NginX

## Task 4


