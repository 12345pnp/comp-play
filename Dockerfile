FROM ruby:2.7

WORKDIR /srv/jekyll
COPY . .

RUN apt-get update && apt-get install -y build-essential nodejs
RUN gem install bundler -v 2.2.8
RUN bundle install

EXPOSE 4000
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]