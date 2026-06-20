# FROM node:22-alpine AS base

# FROM base AS deps
# WORKDIR /app
# COPY package.json package-lock.json* ./
# RUN npm i

# FROM base AS builder
# WORKDIR /app
# COPY --from=deps /app/node_modules ./node_modules
# COPY . .
# RUN npm run build

# FROM base AS runner
# WORKDIR /app
# ENV NODE_ENV=production
# ENV PORT=3000

# RUN addgroup --system --gid 1001 nodejs \
#     && adduser --system --uid 1001 nextjs

# COPY --from=builder /app/public ./public
# COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
# COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

# USER nextjs
# EXPOSE 3000

# CMD ["node", "server.js"]


# --- Stage 1: Get global monorepo footprints ---
FROM node:22-alpine AS base
WORKDIR /app
RUN npm install -g turbo

# --- Stage 2: Create a minimal dependency workspace ---
FROM base AS deps
COPY package.json package-lock.json* ./
# If you have a root package-lock, cache the global root node_modules here
RUN npm install --prefer-offline --no-audit

# --- Stage 3: Development Target ---
FROM deps AS deps-dev
ENV NODE_ENV=development
CMD ["npm", "run", "dev"]

# --- Stage 4: Production Compiling Asset Stack ---
FROM deps AS builder
COPY . .
RUN npm run build

FROM base AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV PORT=3000

COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

EXPOSE 3000
CMD ["node", "server.js"]