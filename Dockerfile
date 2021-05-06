FROM public.ecr.aws/lambda/ruby:2.7

WORKDIR ${LAMBDA_TASK_ROOT}

RUN yum update -y
RUN yum groupinstall -y "Development Tools"
RUN yum install -y amazon-linux-extras
RUN amazon-linux-extras install epel -y
RUN yum install -y chromium

COPY bin/chromedriver /usr/local/bin/
COPY lambda_function.rb Gemfile ${LAMBDA_TASK_ROOT}

# Install NPM dependencies for function
RUN bundle install --path vendor/bundle --clean

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "lambda_function.lambda_handler" ]
