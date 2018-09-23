FROM nginx:1.15.3-alpine
COPY www /usr/share/nginx/html
COPY nginx-default.conf /etc/nginx/conf.d/default.conf