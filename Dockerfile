FROM ruby:2.5.0

# docker側のosアップデート
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       nodejs           


# 作業ディレクトリの作成、設定 app_nameと言うディレクトリ作成
RUN mkdir /app_name 
#環境変数 APP_ROOT(任意名)を 作業ディレクトリ /app_nameに設定
ENV APP_ROOT /app_name 
#作業ディレクトリをAPP_ROOT(=/app_name)に設定
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileをDocker側に追加(ADD)
# ./Gemfile(ローカルのDockerfileがあるディレクトリからの相対パス)を$APP_ROOT/に追加
ADD ./Gemfile $APP_ROOT/Gemfile
#Gemfile.lockも同様に追加
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileのbundle install
RUN bundle install
ADD . $APP_ROOT