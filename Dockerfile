FROM node:alpine as prodappbuilder

WORKDIR /var/app

COPY ./package.json ./

RUN npm install

COPY ./ ./

RUN npm run build


#New Block (new container to deploy into ngnix)
FROM nginx

EXPOSE 80

COPY --from=prodappbuilder "/var/app/build" "/usr/share/nginx/html"

