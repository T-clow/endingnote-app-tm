FROM --platform=linux/amd64 ruby:3.2.2

RUN apt-get update -qq && apt-get install -y build-essential default-mysql-client

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs && \
    npm install -g yarn

ENV app_path /rails_app
RUN mkdir ${app_path}
WORKDIR ${app_path}

COPY ./Gemfile ${app_path}/Gemfile
COPY ./Gemfile.lock ${app_path}/Gemfile.lock

RUN bundle install
COPY . ${app_path}

COPY ./start.sh /start.sh
RUN chmod 744 /start.sh
CMD ["sh", "/start.sh"]

# Google Chromeの直接ダウンロードとインストール
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  && dpkg -i google-chrome-stable_current_amd64.deb || apt-get install -yf \
  && rm google-chrome-stable_current_amd64.deb

# ChromeDriverのインストール
ARG CHROMEDRIVER_VERSION=94.0.4606.61
RUN wget -q --continue -P /chromedriver "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip" \
  && unzip /chromedriver/chromedriver* -d /usr/local/bin/ \
  && rm /chromedriver/chromedriver_linux64.zip
