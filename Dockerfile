FROM nginx:1.15.3-alpine
COPY nginx-default.conf /etc/nginx/conf.d/default.conf
COPY www /usr/share/nginx/html
