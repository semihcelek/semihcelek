# Stage 1: Build the site
FROM klakegg/hugo:ext-alpine AS builder

# Set working directory
WORKDIR /src

# Copy your source code
COPY . .

# Initialize submodules (LoveIt theme) and build
# We use the 'extended' Hugo version for LoveIt's SCSS
RUN git submodule update --init --recursive
RUN hugo

# Stage 2: Serve the site
FROM caddy:alpine

# Copy built files from the builder stage
COPY --from=builder /src/public /usr/share/caddy

# Expose port 80
EXPOSE 80