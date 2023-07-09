## Tasks
1. Add 1Gb swap.
2. Configure Nginx to return static files included in index.php from http://its-test-public.s3-website-us-east-1.amazonaws.com/
3. Install a self-signed certificate and configure traffic redirect from HTTP to HTTPS
4. Create an SFTP account with access only to files and site logs.
## Solution
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
