# PGNC Nginx Gateway

This directory builds the Nginx container that fronts the PGNC stack. The image reverse proxies traffic to the Angular SSR app, NestJS API, and Solr client while optionally terminating TLS with the certificates maintained by the `certbot` service.

## Files

- `Dockerfile` – extends `nginx:stable-alpine`, installs `envsubst`, and wires in the custom entrypoint
- `entrypoint.sh` – generates the runtime config from a template, conditionally injecting the HTTPS server block when the expected Let’s Encrypt artifacts are present
- `nginx.conf` – reference configuration for local testing and authoring (mirrors the HTTP server block in the template)
- `ssl-server-block.conf` – server block appended at runtime when `/etc/letsencrypt/live/plant.genenames.org/*` exists

> The image expects a companion `nginx.conf.template` with a `${SSL_SERVER_BLOCK}` placeholder; create or update it alongside `nginx.conf` before rebuilding the container.

## How It Works

1. Docker Compose mounts the `certbot-etc` named volume at `/etc/letsencrypt` inside this container.
2. On start, `entrypoint.sh` checks for live certificates and exports the HTTPS block if present.
3. `envsubst` renders `/etc/nginx/templates/nginx.conf.template` to `/etc/nginx/conf.d/default.conf` and runs `nginx -t` before launching the master process.
4. Upstreams (`ssr`, `api`, `solr`) point to the internal service names defined in `docker-compose.yml`.

## Customising Domains and Ports

- Adjust `server_name` directives in both `nginx.conf` and `ssl-server-block.conf` (and propagate changes to the template) when onboarding new hostnames.
- The public listener ports are driven by `.env` values `LOCALHOST_NGINX_PORT` and `LOCALHOST_NGINX_SSL_PORT`; update them if you need alternative bindings.
- Modify upstream targets if service ports change. Keep the health checks in `docker-compose.yml` in sync with any rewrites you introduce.

## Build and Deployment

```bash
# Rebuild the image after modifying configuration files
docker compose build nginx

# Start the proxy (requires dependent services via Compose)
docker compose up -d nginx

# Tail logs for troubleshooting
docker compose logs -f nginx
```

For TLS issuance or renewal run the `certbot` service (see `certbot/README.md`) before restarting Nginx so the HTTPS block can be enabled automatically.

## Verification Checklist

- `docker compose ps nginx` shows `healthy` (or `running` if a custom health check is provided).
- `curl -I http://localhost:${LOCALHOST_NGINX_PORT}/api/health` returns a `200` from the NestJS service.
- `curl -I https://plant.genenames.org` (substitute your domain) succeeds once certificates are present.
- `nginx -T` inside the container displays the rendered configuration for inspection.

## Troubleshooting Tips

- **HTTP only startup** – expected when certificates are missing; obtain or mount the Let’s Encrypt data then restart the container.
- **502/504 errors** – confirm upstream services are healthy and the proxy hostnames match the Compose service names.
- **Configuration failures** – review the `envsubst` output echoed during container start and run `docker compose logs nginx` for context.
- **Certificate changes** – recycle the container after renewals to ensure Nginx reloads the updated files.

For holistic deployment context, refer to `docker-compose.yml` and the root `README.md`.
