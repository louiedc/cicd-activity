FROM nginx:alpine
COPY . /usr/share/nginx/html
COPY test.side /usr
