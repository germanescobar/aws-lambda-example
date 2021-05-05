FROM lambci/lambda:build-ruby2.7

RUN amazon-linux-extras install epel -y
RUN yum install -y chromium
COPY bin/chromedriver /usr/local/bin/

RUN gem update bundler

CMD "/bin/bash"
