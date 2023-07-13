## Tasks
1. Add 1Gb swap.
2. Configure Nginx to return static files included in index.php from http://its-test-public.s3-website-us-east-1.amazonaws.com/
3. Install a self-signed certificate and configure traffic redirect from HTTP to HTTPS
4. Create an SFTP account with access only to files and site logs.
## Solution
- **Check the [website](https://ec2-44-202-246-183.compute-1.amazonaws.com)**
- **SFTP connection: `itsyndicate@44.202.246.183` Passw: `Green45#`**
## Fix Nginx module
The machine image contains broken Nginx module. Module *libnginx-mod-http-geoip2* can not be loaded. It should be reinstalled.
1. Update all packages:
```
sudo apt-get update
sudo apt-get upgrade
'''
2. Check the nginx
```
sudo systemctl status nginx
```
3. Remove the broken module *libnginx-mod-http-geoip2*:
```
sudo dpkg -r  --force-depends libnginx-mod-http-geoip2
```
4. Instal new module *libnginx-mod-http-geoip2*:
```
sudo add-apt-repository ppa:maxmind/ppa
sudo apt update
sudo apt upgrade
```
The package manager found out that module *libnginx-mod-http-geoip2* need to be installed:
```
sudo apt --fix-broken install
```
5. Check modules:
```
sudo dpkg -l | grep nginx
```
We can see module *libnginx-mod-http-geoip2* is OK.
6. Start Nginx:
```
sudo systemctl start nginx
sudo systemctl status nginx
```

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
sudo chmod 666 /etc/fstab
sudo echo '/swapfile1GB none swap sw 0 0' >> /etc/fstab
sudo chmod 644 /etc/fstab
```

### Task 2

1. Add `location` block into `server` defenition in *[/etc/nginx/sites-enabled/default](sites-enabled_default)*:
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
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt
```
follow the command's prompt to enter the neccessery data.
```
sudo mv nginx.crt /etc/nginx/certificate.crt
sudo mv nginx.key /etc/nginx/private.key
```

2. Add redirection directive into HTTPP `server` block in  *[/etc/nginx/sites-enabled/default](sites-enabled_default)*
```
return 301 https://$host$request_uri;
```
3. Add HTTPS `server` block:
```
server {
  listen 443 ssl;
  server_name ec2-44-202-246-183.compute-1.amazonaws.com;
  ssl_certificate /etc/nginx/certificate.crt;
  ssl_certificate_key /etc/nginx/private.key;
# Copy all the rest from HTTP server block
...
}
```
4. Restart NginX
5. Add fierwall rule for port 443
```
sudo ufw allow 443
sudo ufw status
```

### Task 4

1. Install the OpenSSH server
2. Add SFTP user, group
```
sudo groupadd sftpusers
sudo useradd -m -G sftpusers -s /usr/sbin/nologin itsyndicate
sudo passwd itsyndicate
```
3. Prepare SFTP user directory
```
 sudo -s
 cd /home/itsyndicate
 mkdir html logs
 chown root:sftpusers html logs
 chmod 755 html logs
 exit
```
4. Set requires owner and permissions to the target dirs
```
 sudo chown -R root:sftpusers /var/log/nginx/
 sudo chmod 755 /var/log/nginx/
 sudo chown -R root:sftpusers /var/www/html/
 sudo chmod 755 /var/www/html/
```
5. Mount target dirs */var/www/html* and */var/log/nginx* in to SFTP user home dir
```
 sudo -s
 cd /home/itsyndicate
 sudo mount -o bind  /var/www/html/ ./html/
 sudo mount -o bind  /var/log/nginx/ ./logs/
 exit
```
6. Edit *[/etc/ssh/sshd_config](sshd_config)*
```
PasswordAuthentication yes
Subsystem       sftp    internal-sfp
Match Group sftpusers
  ForceCommand internal-sftp
  ChrootDirectory  /home/%u
```                                     
7. Reastart SSH
```
sudo service ssh restart
```


