FROM centos:centos7
MAINTAINER Jeff Mesnil <jmesnil@gmail.com>

# install deps required by our build
RUN yum -y update && yum install -y \
    autoconf \
    automake \
    bison \
    bzip2 \
    epel-release \
    gcc \
    gcc-c++ \
    git \
    ImageMagick-devel \
    libcurl-devel \
    libffi-devel \
    libtool \
    libxml2 \
    libxml2-devel \
    libxslt \
    libxslt-devel \
    libyaml-devel \
    make \
    openssl-devel \
    patch \
    readline-devel \
    ruby-devel \
    sqlite-devel \
    tar \
    which \
    wget
# required for minify... sigh...
RUN yum install -y nodejs
RUN yum install -y s3cmd

RUN useradd -m jmesnil

USER jmesnil
ENV HOME /home/jmesnil
WORKDIR /home/jmesnil/

ENV RUBY_VERSION 2.2.4

RUN gpg2 --keyserver hkp://pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby=$RUBY_VERSION
RUN bash -l -c "rvm use $RUBY_VERSION"
RUN bash -l -c "rvm cleanup all"
RUN bash -l -c "gem install bundler"
# install base gem's, if any changes user only need to install differences.
ADD ./Gemfile /home/jmesnil/
RUN bash -l -c "bundle install"

EXPOSE 4242

ENTRYPOINT [ "/bin/bash", "-l" ]
