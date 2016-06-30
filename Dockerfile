FROM alpine:3.4

# Add necessary packages
RUN apk --update add bash tzdata ruby ruby-dev openssl-dev build-base nodejs

# Create the run user and group
RUN addgroup webservice && adduser webservice -G webservice -D

# set the timezone appropriatly
ENV TZ=EST5EDT
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

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
