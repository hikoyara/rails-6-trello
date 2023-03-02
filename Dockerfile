FROM ruby:2.7.5

RUN apt-get update -qq && apt-get install -y build-essential postgresql-client

WORKDIR /rails-6-trello

# install nodejs(15系)
RUN curl -fsSL https://deb.nodesource.com/setup_15.x | bash - && apt-get install -y nodejs

# npm自体のバージョンを最新にする
RUN npm install -g npm

# install yarn
RUN npm install -g yarn

# gem
COPY Gemfile /rails-6-trello/
COPY Gemfile.lock /rails-6-trello/
RUN gem install bundler
RUN bundle install

# コンテナー起動時に毎回実行されるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# 3000番ポートをリンクしたサービスのみに公開
EXPOSE 3000