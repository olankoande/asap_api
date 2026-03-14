# ── Stage 1 : Build ───────────────────────────────────────────────────────────
FROM node:20-alpine AS build

WORKDIR /usr/src/app

# Copier package + schéma Prisma avant le reste (cache npm ci)
COPY package*.json ./
COPY prisma ./prisma

# Installer toutes les dépendances (dev inclus pour tsc + prisma generate)
RUN npm ci --include=dev --ignore-scripts
RUN npx prisma generate

# Copier le reste du code puis compiler
COPY . .
RUN npm run build

# ── Stage 2 : Production ──────────────────────────────────────────────────────
FROM node:20-alpine AS release

WORKDIR /usr/src/app

ENV NODE_ENV=production

# OpenSSL requis par Prisma sur Alpine
RUN apk add --no-cache openssl

# Copier artefacts du build
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/node_modules/.prisma ./node_modules/.prisma
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/prisma ./prisma
COPY --from=build /usr/src/app/public ./public
COPY package*.json ./

EXPOSE 3000

# Démarrage direct — MySQL est garanti prêt par le depends_on service_healthy
CMD ["node", "dist/server.js"]
