FROM node:10-alpine as build-deps
WORKDIR /app
COPY . .
RUN yarn --production
RUN yarn build
# production environment
FROM nginx:stable-alpine 
COPY --from=build-deps /app/build /usr/share/nginx/html
COPY --from=build-deps /app/nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]