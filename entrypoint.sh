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




# Check if security config exists
if [ -f "/etc/nginx/security.conf" ]; then
    echo "Security config found. Inlining into nginx.conf."
    SECURITY_CONFIG=$(cat /etc/nginx/security.conf)
    export SECURITY_CONFIG
else
    echo "Security config not found. Skipping inlined security config."
    export SECURITY_CONFIG=""
fi

# Check if API security config exists
if [ -f "/etc/nginx/api-security.conf" ]; then
    echo "API security config found. Inlining into nginx.conf."
    API_SECURITY_CONFIG=$(cat /etc/nginx/api-security.conf)
    export API_SECURITY_CONFIG
else
    echo "API security config not found. Skipping inlined API security config."
    export API_SECURITY_CONFIG=""
fi

# Generate the final nginx configuration using envsubst
envsubst '${SSL_SERVER_BLOCK} ${SECURITY_CONFIG} ${API_SECURITY_CONFIG}' < /etc/nginx/templates/nginx.conf.template > /etc/nginx/conf.d/default.conf



echo "Generated nginx configuration:"
echo "================================"
cat /etc/nginx/conf.d/default.conf
echo "================================"

# Test nginx configuration
nginx -t

# Start nginx
exec nginx -g "daemon off;"
