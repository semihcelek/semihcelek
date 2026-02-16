# Stage 1: Build the site
# klakegg/hugo images come with git pre-installed, but we'll avoid using it
FROM klakegg/hugo:ext-alpine AS builder

WORKDIR /src

# Copy all files (including submodules already pulled by Portainer)
COPY . .

# Build the site without touching git
# We use --minify for production performance
RUN hugo --minify

# Stage 2: Serve the site
FROM caddy:alpine
# Copy the generated static files to Caddy's default directory
COPY --from=builder /src/public /usr/share/caddy

EXPOSE 80