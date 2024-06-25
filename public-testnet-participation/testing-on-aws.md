# Testing on AWS

## Running a Validator using an AWS EC2 Instance

### Step 1: Create an AWS EC2 Instance

1. **Launch an Instance**:
   * Choose a `t2.large` instance type.
   * Use the `Ubuntu 22.04` operating system.
   * Allocate at least `20GB` of storage (this may need to be increased as the chain grows).
2. **Create a Key Pair**:
   * Select the \*.pem file option when creating the key pair.
   * Move the downloaded key to your `~/` directory for easy access.
3.  **Set Key Permissions**:

    ```sh
    chmod 400 {keyname}.pem
    ```
4.  **Connect to Your Instance**:

    * Use the provided SSH command from the AWS console to connect:

    ```sh
    ssh -i "{keyname}.pem" ubuntu@{ec2-ip-address}.compute-1.amazonaws.com
    ```

### Step 2: Set Up the Environment

1.  **Update and Install Necessary Packages**:

    ```sh
    sudo apt-get update
    sudo apt-get install -y jq yq sed
    sudo apt remove --autoremove golang-go
    sudo apt install -y snapd
    sudo snap install --classic --channel=1.21/stable go
    ```
2.  **Clone the Layer Repository**:

    ```sh
    git clone https://github.com/tellor-io/layer.git
    ```
3.  **Verify Go Installation**:

    ```sh
    go version
    ```
4.  **Navigate to the Layer Directory and Run the Setup Script**:

    ```sh
    cd layer
    sh ./start_scripts/start_one_node_aws.sh
    ```

### Step 3: Configure Security and Networking

1. **Set Up Inbound and Outbound Rules**:
   * Go to your EC2 instance page in the AWS console.
   * In the security section, edit the inbound rules to open the following ports:
     * `80` (HTTP)
     * `443` (HTTPS)
     * `1317` (Layer Swagger API)
     * `26656` (P2P)
     * `26657` (RPC)
     * `22` (SSH, set to "My IP" for security)
   * For outbound rules, allow all traffic.
2. **Assign an IPv6 Address**:
   * Go to your AWS instance dashboard.
   * Click on "Actions" -> "Networking" -> "Manage IP addresses".
   * Assign a new IPv6 address to your instance and save.

### Step 4: Set Up the Firewall

1.  **Install and Configure UFW**:

    ```sh
    sudo apt-get install -y ufw net-tools
    sudo ufw disable
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow 22/tcp   # SSH access
    sudo ufw allow 26656    # Layer P2P
    sudo ufw allow 26657    # Layer RPC
    sudo ufw allow 1317     # Layer Swagger API
    sudo ufw allow 80       # HTTP
    sudo ufw allow 443      # HTTPS
    sudo ufw enable
    ```

### Step 5: Set Up Nginx and SSL

1.  **Install Nginx and Certbot**:

    ```sh
    sudo apt-get install -y nginx apache2-utils python3-certbot-nginx
    sudo certbot --nginx -d {domain-name}.com
    ```
2.  **Configure Monthly SSL Certificate Renewal**:

    ```sh
    sudo nano /etc/crontab
    ```

    Add the following line:

    ```sh
    @monthly root certbot -q renew
    ```
3.  **Configure Nginx for SSL**:

    ```sh
    sudo nano /etc/nginx/conf.d/ssl.conf
    ```

    Add the following configuration:

    ```nginx
    server {
        server_name {domain-name}.com;
        location / {
            if ($request_method = OPTIONS) {
                add_header Content-Length 0;
                add_header Content-Type text/plain;
                add_header Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS";
                add_header Access-Control-Allow-Origin $http_origin;
                add_header Access-Control-Allow-Headers "Authorization, Content-Type";
                add_header Access-Control-Allow-Credentials true;
                return 200;
            }
            proxy_pass http://localhost:1317;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_cache_bypass $http_upgrade;
        }
        location /rpc {
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
            proxy_set_header X-NginX-Proxy true;
            proxy_pass  http://127.0.0.1:26657/;
        }
        location /p2p {
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
            proxy_set_header X-NginX-Proxy true;
            proxy_pass  http://127.0.0.1:26656/;
        }
        listen 443 ssl;
        listen [::]:443 http2 ssl;
        ssl_certificate /etc/letsencrypt/live/{domain-name}.com/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/{domain-name}.com/privkey.pem;
        include /etc/letsencrypt/options-ssl-nginx.conf;
        ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
    }
    server {
      if ($host = tellorlayer.com) {
          return 301 https://$host$request_uri;
      }
      listen 80 ;
      listen [::]:80 ;
      server_name {domain-name}.com;
      return 404;
    }
    ```
4.  **Verify and Restart Nginx**:

    ```sh
    sudo nginx -t
    sudo service nginx restart
    ```

### Step 6: Start the Chain

1.  **Run the Start Script**:

    ```sh
     sh join_chain_new_node_linux.sh
    ```
2. **Verify Setup**:
   * Once the chain is running, navigate to `https://{domain-name}.com/` to see the Swagger API page.

{% hint style="success" %}
Congratulations! You have successfully set up your AWS EC2 instance and started participating in the Tellor Layer Public Testnet. For more information and support, reach out in our [discord](https://discord.gg/tellor).
{% endhint %}
