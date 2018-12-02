server {
    listen 80;
    server_name godaveorgohome.com www.godaveorgohome.com;
    access_log off;
    error_log off;
    return 301 https://$server_name$request_uri;
}
server {
    listen 443 ssl http2;
    server_name www.godaveorgohome.com godaveorgohome.com;
    add_header Strict-Transport-Security "max-age=31536000; includeSubdomains" always;
    add_header PHPCACHE $upstream_cache_status;
    gzip on;
    gzip_types text/plain application/javascript application/x-javascript text/javascript text/xml text/css;
    gzip_min_length 1000;
    port_in_redirect off;
    client_max_body_size 16M;
    access_log /var/log/nginx/godaveorgohome.com.access.log;
    error_log /var/log/nginx/godaveorgohome.com.error.log;
    ssl_certificate /etc/letsencrypt/live/www.godaveorgohome.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/www.godaveorgohome.com/privkey.pem;
    ssl_trusted_certificate /etc/letsencrypt/live/www.godaveorgohome.com/chain.pem;
    root /home/blaster/www/godaveorgohome.com;
    index index.php;
    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    # Cache static files for as long as possible
    location ~*.(ogg|ogv|svg|svgz|eot|otf|woff|mp4|ttf|css|rss|atom|js|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|ppt|tar|mid|midi|wav|bmp|rtf|cur)$
    {
        expires max;
        log_not_found off;
        access_log off;
    }

    set $wp_bypass_cache 0;

    if ($request_method = POST)
    {
        set $wp_bypass_cache 1;
    }
    if ($query_string != "")
    {
        set $wp_bypass_cache 1;
    }
    if ($request_uri ~* "/wp-admin/|/xmlrpc.php|/wp-(app|cron|login|register|mail).php|wp-.*.php|/feed/|index.php|wp-comments-popup.php|wp-links-opml.php|wp-locations.php|sitemap(_index)?.xml|[a-z0-9_-]+-sitemap([0-9]+)?.xml")
    {
        set $wp_bypass_cache 1;
    }
    if ($http_cookie ~* "comment_author|wordpress_[a-f0-9]+|wp-postpass|wordpress_no_cache|wordpress_logged_in")
    {
        set $wp_bypass_cache 1;
    }

    # Deny public access to wp-config.php
    location ~* wp-config.php
    {
        deny all;
    }
    location ~ \.php$ {
        try_files $uri =404;
        include fastcgi_params;
        fastcgi_pass unix:/run/php/php7.0-fpm.sock;
        fastcgi_split_path_info ^(.+\.php)(.*)$;
        fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_cache cache;
        fastcgi_cache_valid 200 301 302 60m;
        fastcgi_cache_bypass $wp_bypass_cache;
        fastcgi_no_cache $wp_bypass_cache;
    }
}
