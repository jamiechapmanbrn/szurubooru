FROM node:9 as builder
WORKDIR /opt/app

COPY package.json ./
RUN npm install

COPY . ./

ARG BUILD_INFO="docker-latest"
ARG CLIENT_BUILD_ARGS=""
RUN BASE_URL="__BASEURL__" node build.js ${CLIENT_BUILD_ARGS}

RUN find public/ -name public/index.html -prune -o -type f -size +5k \
        -print0 | xargs -0 -- gzip -6 -k


FROM nginx:alpine
WORKDIR /var/www

RUN \
    # Create init file
    echo "#!/bin/sh" >> /init && \
    echo 'sed -i "s|__BACKEND__|${BACKEND_HOST}|" /etc/nginx/nginx.conf' \
        >> /init && \
    echo 'sed -i "s|__BASEURL__|${BASE_URL:-/}|" /var/www/index.htm' >> /init && \
    echo 'exec nginx -g "daemon off;"' >> /init && \
    chmod a+x /init

CMD ["/init"]
VOLUME ["/data"]

COPY nginx.conf.docker /etc/nginx/nginx.conf
COPY --from=builder /opt/app/public/ .
