FROM node:14-alpine

WORKDIR /app

COPY package.json .
COPY package-lock.json .
RUN npm install

COPY . .

ENV PORT 3000
EXPOSE 3000

CMD ["npm", "start"]
