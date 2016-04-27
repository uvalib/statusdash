FROM centos:7

RUN yum -y update
RUN yum -y install ruby && yum -y install gcc gcc-c++ make automake autoconf curl-devel openssl-devel zlib-devel httpd-devel apr-devel apr-util-devel libxml2 libxml2-devel libxslt libxslt-devel epel-release && yum -y install ruby-rdoc ruby-devel nodejs

# Create the run user and group
RUN groupadd -r webservice && useradd -r -g webservice webservice

# Specify home 
ENV APP_HOME /statusdash
WORKDIR $APP_HOME

# Create necessary directories
RUN chown -R webservice $APP_HOME && chgrp -R webservice $APP_HOME
RUN mkdir /home/webservice
RUN chown -R webservice /home/webservice && chgrp -R webservice /home/webservice

# Specify the user
USER webservice

# update the path
ENV PATH $PATH:~/bin

# install necessary gems
RUN echo 'gem: --no-document' >> ~/.gemrc
RUN gem install bundler
RUN gem install dashing

# port and run command
EXPOSE 3030
CMD dashing start

# add necessarey assets
ADD . $APP_HOME
RUN bundle install
