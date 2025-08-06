#!/bin/bash
set -e

# Check if SSL certificates exist
if [ -f "/etc/letsencrypt/live/plant.genenames.org/fullchain.pem" ] && [ -f "/etc/letsencrypt/live/plant.genenames.org/privkey.pem" ]; then
    echo "SSL certificates found. Enabling HTTPS server block."
    # Read the SSL server block content
    SSL_SERVER_BLOCK=$(cat /etc/nginx/ssl-server-block.conf)
    export SSL_SERVER_BLOCK
else
    echo "SSL certificates not found. Running HTTP-only configuration."
    # Set empty SSL server block
    export SSL_SERVER_BLOCK=""
fi

# Generate the final nginx configuration using envsubst
envsubst '${SSL_SERVER_BLOCK}' < /etc/nginx/templates/nginx.conf.template > /etc/nginx/conf.d/default.conf

echo "Generated nginx configuration:"
echo "================================"
cat /etc/nginx/conf.d/default.conf
echo "================================"

# Test nginx configuration
nginx -t

# Start nginx
exec nginx -g "daemon off;"
