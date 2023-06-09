FROM node:13.12.0-alpine as build
WORKDIR /app
ENV PATH /app/node_module/.bin:$PATH
COPY package.json ./
COPY package-lock.json ./
RUN npm install react-scripts@3.4.1 -g --silent
COPY . ./
RUN npm run build

FROM nginx:stable-alpine
COPY --from=buildbuild /app/build /user/share/nginx/html
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
