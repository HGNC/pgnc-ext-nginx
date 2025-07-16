#!/bin/bash
set -e

# Copy the configuration template to the correct location
cp /etc/nginx/templates/default.conf.template /etc/nginx/conf.d/default.conf

# Execute the original command (start nginx)
exec "$@"
