FROM       fedora:latest

# install the required dependencies to complile natice extensions
RUN        dnf -y install gcc-c++ make ruby-devel libxml2-devel libxslt-devel findutils git ruby nodejs s3cmd

RUN        groupadd -r dev && useradd  -g dev -u 1000 dev
RUN        mkdir -p /home/dev
RUN        chown dev:dev /home/dev
RUN        gem update --system

# From here we run everything as dev user
USER       dev

# Setup all the env variables needed for ruby
ENV        HOME /home/dev
ENV        GEM_HOME $HOME/.gems
ENV        GEM_PATH $HOME/.gems
ENV        PATH $PATH:$GEM_HOME/bin
RUN        mkdir $HOME/.gems

# Install Rake and Bundler for driving the Awestruct build & site
RUN        gem install rake bundler

RUN         mkdir $HOME/jmesnil.net/
ADD         ./Gemfile $HOME/jmesnil.net
WORKDIR     $HOME/jmesnil.net
RUN         bundle version
RUN         bundle install

EXPOSE     4242

CMD [ "/bin/bash" ]
