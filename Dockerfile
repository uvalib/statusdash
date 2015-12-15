FROM centos:7

RUN yum -y update
RUN yum -y install ruby
RUN yum -y install gcc gcc-c++ make automake autoconf curl-devel openssl-devel zlib-devel httpd-devel apr-devel apr-util-devel sqlite-devel libxml2 libxml2-devel libxslt libxslt-devel mysql-devel patch epel-release
RUN yum -y install ruby-rdoc ruby-devel
RUN yum -y install nodejs rubygems
RUN gem install bundler --no-rdoc --no-ri
RUN gem install dashing --no-rdoc --no-ri
#RUN gem uninstall -I eventmachine
#RUN gem install eventmachine

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
