# NGINX Configuration for PGNC External Stack

This directory contains NGINX configuration files for the PGNC External Stack project.

## Overview

NGINX serves as the reverse proxy and load balancer for the external-facing components of the PGNC stack.

## Structure

- `conf.d/` - Configuration files
- `certs/` - SSL certificates (not tracked in git)

## Configuration

1. Place SSL certificates in the `certs/` directory
2. Update configuration files as needed
3. Test configuration with `nginx -t`
4. Reload NGINX with `nginx -s reload`

## Usage

Refer to the main project documentation for deployment instructions and integration details.
