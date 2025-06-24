FROM node:18 as frontend-build
WORKDIR /app/vitereact
COPY vitereact/package.json ./
RUN npm install --legacy-peer-deps
COPY vitereact .
RUN npm run build

FROM node:18 as backend
WORKDIR /app/backend
COPY backend/package.json ./
RUN npm install --production
COPY backend .

FROM node:18
WORKDIR /app
COPY --from=backend /app/backend .
COPY --from=frontend-build /app/vitereact/dist ./public
CMD ["node", "server.js"]
