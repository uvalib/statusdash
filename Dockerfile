FROM centos:7

RUN yum -y update
RUN yum -y install ruby && yum -y install gcc gcc-c++ make automake autoconf curl-devel openssl-devel zlib-devel httpd-devel apr-devel apr-util-devel libxml2 libxml2-devel libxslt libxslt-devel epel-release && yum -y install ruby-rdoc ruby-devel nodejs

RUN echo 'gem: --no-document' >> ~/.gemrc
RUN gem install bundler
RUN gem install dashing

RUN ln -s /usr/local/share/gems/gems/thin-1.6.4/ext/thin_parser/thin_parser.so /usr/local/share/gems/gems/thin-1.6.4/lib

ENV APP_HOME /statusdash
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

RUN bundle install

# not sure why...
RUN gem uninstall -I eventmachine
RUN bundle install

EXPOSE 3030
CMD dashing start
