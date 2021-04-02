FROM ruby:3.0.0-slim as ruby-base

# Default env vars (applies to containers made from this image)
# Can be overriden at run-time with -e
ENV APP_DIR=/app
# Sets the path to allow running bundler binstubs
ENV PATH="${PATH}:${APP_DIR}/bin"
ENV BUNDLE_PATH=/bundle/vendor
ENV NODE_VERSION 14.15.4
ENV YARN_VERSION 1.22.5

# Build args - shell variables assigned at build time.
# can be overridden at build time with --build-arg
ARG BUNDLER_VERSION=2.2.15
ARG RAILS_ENV=development
ARG BUNDLE_PATH=/bundle/vendor

# Here are the dependencies we need to build our app (and install Rails)
# This example installs the PostgreSQL and SQLite libraries (two commonly used databases in Rails apps).
#
# We're also installing the latest nodejs and yarn packages here for webpacker.
RUN apt-get update -qq && apt-get install -yq curl gnupg2 lsb-release \
    && curl -sL https://deb.nodesource.com/setup_14.x | bash \
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq &&  apt-get install -yq build-essential git ruby-dev libpq-dev \
    libsqlite3-dev postgresql-client nodejs shared-mime-info \
    && apt-get install -yq yarn \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gem install bundler -v $BUNDLER_VERSION

# This creates the APP_DIR that we defined earler 
# and sets it as the default directory in the container created from this image
RUN mkdir ${APP_DIR}
WORKDIR ${APP_DIR}

#
# Here, we copy our gem and npm dependency files into our image.
# We do this here so that when we change dependencies and a rebuild is needed, we can 
# leverage the build cache (everything above this point will not be rebuilt).
#
COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install

COPY package.json yarn.lock ./
RUN yarn install

# Copy all of our app in to the image (use .dockerignore to omit patterns)
COPY . ./

# Declares that we intend to listen on port 3000. This is a declarative documentation instruction
# that doesn't actually publish or open a port.
EXPOSE 3000

# This gets executed when we run a container made from this image
CMD ["bin/rails", "server", "-b", "0.0.0.0"