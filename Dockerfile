FROM nginx:1.25.3-alpine

# Nginx config: serves /usr/share/nginx/html and denies dotfiles (e.g. /.env).
COPY .github/nginx/default.conf /etc/nginx/conf.d/default.conf

# Static assets go under the document root.
COPY www /usr/share/nginx/html

# Runtime env template + generator live OUTSIDE the document root so they are
# never reachable over HTTP. `env.sh` reads `.env` (and any overriding real
# environment variables) and writes `env-config.js` into the served static dir.
COPY .env /app/.env
COPY env.sh /app/env.sh
RUN chmod +x /app/env.sh

# Defense-in-depth: make absolutely sure no stale copy of .env slipped into
# the web root from a previous build.
RUN rm -f /usr/share/nginx/html/.env /usr/share/nginx/html/env.sh

WORKDIR /app

# Generate env-config.js at container start, then hand off to nginx (PID 1).
CMD ["/bin/sh", "-c", "/app/env.sh /usr/share/nginx/html/static/js/env-config.js && exec nginx -g 'daemon off;'"]
