# Compile assets
FROM node:latest AS node
COPY . /app
WORKDIR /app/src
RUN npm install && npm run build:production

# Then build Hugo site
FROM jguyomard/hugo-builder:0.55 AS hugo
ENV HUGO_ENV=production
ENV HUGO_VERSION=0.55.6
COPY --from=node /app /app
WORKDIR /app
RUN hugo -d public
 
# Connect and sync newly built site to s3
FROM python:3.7-alpine
ENV AWSCLI_VERSION='1.16.265'
RUN apk add --no-cache --upgrade bash
COPY --from=hugo /app/public /public
RUN pip install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}
ADD bin/entrypoint.sh /bin/entrypoint.sh
ENTRYPOINT ["bin/entrypoint.sh"]
