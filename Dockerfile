FROM alpine:3.8

# update the packages
RUN apk update && apk upgrade && apk add bash tzdata ruby ruby-dev openssl-dev build-base nodejs ca-certificates

# Create the run user and group
RUN addgroup --gid 18570 sse && adduser --uid 1984 docker -G sse -D

# set the timezone appropriatly
ENV TZ=EST5EDT
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install necessary gems
RUN gem install bundler io-console --no-ri --no-rdoc

# Copy the Gemfile into the image and temporarily set the working directory to where they are.
WORKDIR /tmp
ADD Gemfile Gemfile
RUN bundle install

# Specify home 
ENV APP_HOME /statusdash
WORKDIR $APP_HOME

# update ownership as necessary
RUN chown -R docker $APP_HOME && chgrp -R sse $APP_HOME

# update the path
ENV PATH $PATH:~/bin

# add necessarey assets
ADD . $APP_HOME
RUN bundle install

# specify the user
USER docker

# port and run command
EXPOSE 3030
CMD scripts/entry.sh

# Move in necessary helper scripts
COPY data/container_bash_profile /home/docker/.profile

# Add the build tag
COPY buildtag.* $APP_HOME/
