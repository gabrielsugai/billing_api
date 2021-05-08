FROM ruby:3.0.1

ENV INSTALL_PATH /opt/app
ENV BUNDLER_VERSION 2.2.15

RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

RUN gem install bundler -v $BUNDLER_VERSION
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

COPY . .

CMD "rspec"