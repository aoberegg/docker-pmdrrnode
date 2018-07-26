FROM mths/docker-pmdrr


RUN mkdir -p /Frontend/web

COPY package.json /Frontend/app/package.json
COPY bower.json /Frontend/app/bower.json

RUN apt-get install -y nodejs nodejs-legacy
RUN apt-get install -y npm

RUN npm install -g bower
RUN npm install -g gulp
RUN npm install -g cordova-hot-code-push-cli

RUN cd /Frontend/app && ls && bower install --allow-root && npm install && cd ~

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.11.0

WORKDIR $NVM_DIR

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN npm install -g protractor jasmine jasmine-spec-reporter

RUN apt-get update
RUN apt-get install -y chromium-browser

RUN ln -s /usr/bin/chromium-browser /usr/bin/google-chrome