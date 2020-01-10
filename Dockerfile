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
LABEL "com.github.actions.name"="S3 Hugo Sync Action"
LABEL "com.github.actions.description"="Build a Hugo Site and deploy to AWS s3 bucket"
LABEL "com.github.actions.icon"="refresh-cw"
LABEL "com.github.actions.color"="green"
LABEL version="0.2.0"
LABEL repository="https://github.com/brown-a2/s3-hugo-sync-action"
LABEL homepage="https://github.com/brown-a2/"
LABEL maintainer="browna2"
ENV AWSCLI_VERSION='1.16.265'
RUN apk add --no-cache --upgrade bash
COPY --from=hugo /app/public /public
RUN pip install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
