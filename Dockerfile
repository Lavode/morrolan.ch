FROM debian:latest AS HUGO

RUN apt-get update -y
RUN apt-get install hugo -y

COPY . /morrolan.ch

RUN hugo -v --source=/morrolan.ch --destination=/morrolan.ch/public

FROM nginx:stable-alpine
RUN rm /usr/share/nginx/html/index.html
COPY --from=HUGO /morrolan.ch/public/ /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
