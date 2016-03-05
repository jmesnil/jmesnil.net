FROM centos:centos7
MAINTAINER Jeff Mesnil <jmesnil@gmail.com>

# install deps required by our build
RUN yum install -y epel-release \
    which \
    tar \
    bzip2 \
    gcc \
    ruby-devel \
    libxml2 \
    libxml2-devel \
    libxslt \
    libxslt-devel \
    libcurl-devel \
    git \
    ImageMagick-devel \
    libyaml-devel \
    autoconf \
    gcc-c++ \
    patch \
    readline-devel \
    libffi-devel \
    openssl-devel \
    make \
    automake \
    libtool \
    bison \
    sqlite-devel \
    wget \
    s3cmd
# required for minify... sigh...
RUN yum install -y nodejs

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
