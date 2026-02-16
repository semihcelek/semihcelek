# Stage 1: Build the site
# hugomods/hugo:exts includes Hugo Extended, Go, and Git by default
FROM hugomods/hugo:exts AS builder

# Set the working directory (hugomods default is /src)
WORKDIR /src

# Copy your source code (assumes you vendored your theme as discussed)
COPY . .

# Build the site
# Using --gc to clean up unused cache files and --minify for performance
RUN hugo --minify --gc

# Stage 2: Serve the site
FROM caddy:alpine

# Copy the generated static files from the builder stage
# hugomods builds into the 'public' folder by default
COPY --from=builder /src/public /usr/share/caddy

# Expose port 80 for Caddy
EXPOSE 80