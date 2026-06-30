FROM nginx:alpine

ARG BRAND_NAME="Harness"
ARG BRAND_DOMAIN="harness.io"
ARG BRAND_INDUSTRY="technology"

COPY . /usr/share/nginx/html

RUN sed -i "s/__BRAND_NAME__/${BRAND_NAME}/g"       /usr/share/nginx/html/brand-config.js && \
    sed -i "s#__BRAND_DOMAIN__#${BRAND_DOMAIN}#g" /usr/share/nginx/html/brand-config.js && \
    sed -i "s/__BRAND_INDUSTRY__/${BRAND_INDUSTRY}/g" /usr/share/nginx/html/brand-config.js

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
