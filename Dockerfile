#------------------ DOCKER CONFIGURATION ------------------

#Primera Etapa
FROM node:slim as build-step

RUN mkdir -p /app

WORKDIR /app

COPY package.json /app

RUN npm install npm@7.17.0

RUN npm install

COPY . /app

RUN npm run build

#Segunda Etapa
FROM nginxinc/nginx-unprivileged

USER root

COPY --from=build-step /app/dist/frontend /usr/share/nginx/html