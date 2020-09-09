FROM ruby:2.7

ENV TZ=America/Sao_Paulo

RUN apt-get update -qq && apt-get install -y \
  nodejs \
  mariadb-client \
  gcc \
  musl-dev \
  bash \
  tzdata \
  ruby-dev \
  ruby-nokogiri \
  # yarn \
  # imagemagick \
  pngcrush \
  optipng \
  # build-base \
  libxml2-dev \
  libxslt-dev; \
  cp /usr/share/zoneinfo/$TZ /etc/localtime; \
  echo $TZ > /etc/timezone;

RUN mkdir /accounting_challenge
WORKDIR /accounting_challenge
COPY Gemfile /accounting_challenge/Gemfile
COPY Gemfile.lock /accounting_challenge/Gemfile.lock
RUN bundle check || bundle install
COPY . /accounting_challenge

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]