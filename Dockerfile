FROM mths/docker-pmdrr


RUN mkdir -p /Frontend/web

COPY package.json /Frontend/app/package.json
COPY bower.json /Frontend/app/bower.json

RUN apt-get install -y nodejs nodejs-legacy
RUN apt-get install -y npm

RUN npm install -g bower
RUN npm install -g gulp

RUN cd /Frontend/app && ls && bower install --allow-root && npm install && cd ~
