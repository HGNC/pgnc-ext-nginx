# Use official Nginx image as base
FROM nginx:stable-alpine

# Install required packages
RUN apk update && apk add --no-cache bash envsubst

# Remove default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy template and SSL block
COPY nginx.conf.template /etc/nginx/templates/nginx.conf.template
COPY ssl-server-block.conf /etc/nginx/ssl-server-block.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose ports
EXPOSE 80
EXPOSE 443

# Use custom entrypoint
ENTRYPOINT ["/entrypoint.sh"]
