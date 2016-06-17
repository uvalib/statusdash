FROM alpine:3.4

# Add bash cos we dont get by default
RUN apk --update add bash ruby ruby-dev openssl-dev build-base nodejs

# Create the run user and group
RUN addgroup webservice && adduser webservice -G webservice -D

# Specify home 
ENV APP_HOME /statusdash
WORKDIR $APP_HOME

# update ownership as necessary
RUN chown -R webservice $APP_HOME && chgrp -R webservice $APP_HOME

# update the path
ENV PATH $PATH:~/bin

# install necessary gems
RUN echo 'gem: --no-document' >> ~/.gemrc
RUN gem install bundler
RUN gem install dashing io-console

# add necessarey assets
ADD . $APP_HOME
RUN bundle install

# specify the user
USER webservice

# port and run command
EXPOSE 3030
CMD dashing start
