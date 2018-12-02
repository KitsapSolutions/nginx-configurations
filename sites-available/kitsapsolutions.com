server {
    listen 80;
    server_name kitsapsolutions.com www.kitsapsolutions.com;
    access_log off;
    error_log off;
    return 301 https://$server_name$request_uri;
}
server {
    listen 443 ssl http2;
    server_name kitsapsolutions.com www.kitsapsolutions.com;
    ssl_certificate /etc/letsencrypt/live/kitsapsolutions.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/kitsapsolutions.com/privkey.pem;
    ssl_trusted_certificate /etc/letsencrypt/live/kitsapsolutions.com/chain.pem;
    add_header Strict-Transport-Security "max-age=31536000; includeSubdomains; preload";

    root /home/blaster/www/kitsapsolutions.com;
    index index.html;

    location ^~ /bidboard/ {
    try_files $uri $uri/ /bidboard/index.html;
    }

    location / {
    try_files $uri $uri/ /index.html;
    }
}
