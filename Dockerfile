# -------- Base versions --------
ARG NODE_VERSION=20-bookworm-slim

# -------- Builder --------
FROM node:${NODE_VERSION} AS builder
WORKDIR /app

ENV NEXT_TELEMETRY_DISABLED=1

COPY package*.json ./
# BuildKit cache accelerates CI builds
RUN --mount=type=cache,target=/root/.npm npm ci

COPY . .
RUN npm run build

# -------- Runner --------
FROM node:${NODE_VERSION} AS runner
WORKDIR /app

ENV NODE_ENV=production \
    NEXT_TELEMETRY_DISABLED=1 \
    PORT=3000

# Non-root for security
USER node

# Copy standalone output + static + public
# This COPY flattens standalone into /app (so /app/server.js must exist after this)
COPY --from=builder --chown=node:node /app/.next/standalone ./
COPY --from=builder --chown=node:node /app/.next/static ./.next/static
COPY --from=builder --chown=node:node /app/public ./public

EXPOSE 3000
CMD ["node", "server.js"]
