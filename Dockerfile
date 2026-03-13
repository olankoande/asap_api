# Étape 1: Build de l'application
FROM node:20-alpine AS build

WORKDIR /usr/src/app

# Copier les fichiers de dépendances et le schéma Prisma
# (le script postinstall exécute `prisma generate` — le schéma doit être présent)
COPY package*.json ./
COPY prisma ./prisma
# Forcer l'installation de toutes les dépendances (y compris devDependencies)
# même si NODE_ENV=production est passé comme build-arg par Coolify
RUN npm install --include=dev --ignore-scripts
RUN npx prisma generate

# Copier le reste du code source
COPY . .

RUN npm run build

# Étape 2: Image de production finale
FROM node:20-alpine AS release

WORKDIR /usr/src/app

ENV NODE_ENV=production

# Installation d'OpenSSL (requis par Prisma Client sur Alpine Linux)
RUN apk add --no-cache openssl

# Copier uniquement les dépendances de production depuis l'étape de build
COPY --from=build /usr/src/app/node_modules ./node_modules
# Copier le code compilé, le schéma et le client Prisma généré
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/prisma ./prisma
COPY --from=build /usr/src/app/node_modules/.prisma ./node_modules/.prisma
COPY --from=build /usr/src/app/public ./public
COPY package*.json ./

EXPOSE 3000

# Commande pour exécuter les migrations et démarrer le serveur
# Assurez-vous d'avoir un script "start:prod" (ex: "node dist/main.js") dans votre package.json
CMD ["sh", "-c", "npx prisma migrate deploy && npm run start"]
