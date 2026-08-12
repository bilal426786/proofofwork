# Production Dockerfile — shared by ALL apps/frontend/* apps.
# One file instead of 14 near-identical copies. Select the app with:
#   docker build -f docker/frontend/Dockerfile --build-arg APP=account .
#
# Uses `turbo prune` to cut the monorepo down to just the one app's
# dependency subgraph before installing — each app's image only pulls in
# what that app actually needs, and the deps layer only invalidates when
# that app's own dependency tree changes (not on every unrelated commit).

FROM node:22-alpine AS base
RUN apk add --no-cache libc6-compat

# --- Stage 1: prune the workspace down to one app's subgraph ---
FROM base AS pruner
ARG APP
WORKDIR /app
RUN npm install -g turbo
COPY . .
RUN turbo prune ${APP} --docker

# --- Stage 2: install only the pruned deps (cacheable independent of source) ---
FROM base AS installer
ARG APP
WORKDIR /app
COPY --from=pruner /app/out/json/ .
RUN npm install --prefer-offline --no-audit --fund=false

# --- Stage 3: bring in full pruned source, build just this app ---
FROM installer AS builder
ARG APP
WORKDIR /app
RUN npm install -g turbo
COPY --from=pruner /app/out/full/ .
RUN turbo run build --filter=${APP}

# --- Stage 4: minimal runtime image ---
FROM node:22-alpine AS runner
ARG APP
ENV APP=${APP}
WORKDIR /app
ENV NODE_ENV=production
ENV PORT=3000

RUN addgroup --system --gid 1001 nodejs \
    && adduser --system --uid 1001 nextjs

COPY --from=builder --chown=nextjs:nodejs /app/apps/frontend/${APP}/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/apps/frontend/${APP}/.next/static ./apps/frontend/${APP}/.next/static
COPY --from=builder --chown=nextjs:nodejs /app/apps/frontend/${APP}/public ./apps/frontend/${APP}/public

USER nextjs
EXPOSE 3000
CMD ["sh", "-c", "node apps/frontend/$APP/server.js"]
