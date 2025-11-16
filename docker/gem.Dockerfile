FROM ruby:3.2-alpine

WORKDIR /usr/src/app

# Install build dependencies for native extensions (if needed later)
RUN apk add --no-cache build-base git

# Default working directory will mount the gem source at runtime via docker-compose

ENV BUNDLE_APP_CONFIG=/usr/local/bundle

CMD ["irb"]


