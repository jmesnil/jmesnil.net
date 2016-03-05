FROM centos:centos7
MAINTAINER Jeff Mesnil <jmesnil@gmail.com>

# install deps required by our build
RUN yum install -y epel-release which tar bzip2 gcc ruby-devel libxml2 libxml2-devel libxslt libxslt-devel libcurl-devel git ImageMagick-devel

# required for minify... sigh...
RUN yum install -y nodejs

RUN yum install -y wget s3cmd

# Add RVM keys
RUN gpg2 --keyserver hkp://pgp.mit.edu --recv-keys D39DC0E3

# Install RVM
RUN curl -L get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements && rvm autolibs enable"

RUN useradd -m jmesnil

USER jmesnil
ENV HOME /home/jmesnil
WORKDIR /home/jmesnil/

ENV RUBY_VERSION 2.2.4

RUN gpg2 --keyserver hkp://pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby=$RUBY_VERSION

RUN bash -l -c "rvm use $RUBY_VERSION"
RUN bash -l -c "rvm cleanup all"
RUN /bin/bash -l -c "gem install bundler"
# install base gem's, if any changes user only need to install differences.
ADD ./Gemfile /home/jmesnil/
RUN /bin/bash -l -c "bundle install"

EXPOSE 4242

ENTRYPOINT [ "/bin/bash", "-l" ]
