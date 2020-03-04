
#Use an existing docker image as a base
FROM node:alpine as builder

#ENV http_proxy http://genproxy.corp.amdocs.com:8080
WORKDIR /app
#copy ./ ./
copy ./package.json ./

#Download and Install a dependency
RUN npm config set https-proxy http://genproxy.amdocs.com:8080/
RUN npm install
copy ./ ./

RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
