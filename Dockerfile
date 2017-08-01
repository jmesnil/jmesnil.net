FROM       fedora:22

# install the required dependencies to complile natice extensions
RUN        dnf -y install gcc-c++ make ruby-devel libxml2-devel libxslt-devel findutils git ruby nodejs s3cmd

RUN        groupadd -r dev && useradd  -g dev -u 1000 dev
RUN        mkdir -p /home/dev
RUN        chown dev:dev /home/dev

# Fix webrick config to avoid a DNS reverse lookup that make it way too slow in Docker
RUN cd /usr/share/ruby/ && grep -l -ri ':DoNotReverseLookup *=> nil'  * | xargs sed -i "s/:DoNotReverseLookup *=> nil/:DoNotReverseLookup => true/"

# From here we run everything as dev user
USER       dev

# Setup all the env variables needed for ruby
ENV        HOME /home/dev
ENV        GEM_HOME $HOME/.gems
ENV        GEM_PATH $HOME/.gems
ENV        PATH $PATH:$GEM_HOME/bin
ENV        LC_ALL en_US.UTF-8
ENV        LANG en_US.UTF-8
RUN        mkdir $HOME/.gems

# Install Rake and Bundler for driving the Awestruct build & site
RUN        gem install -N rake bundler

# Clone in.relation.to in order to run the setup task
#RUN        git clone https://github.com/jmesnil/jmesnil.net.git $HOME/jmesnil.net
#RUN        cd $HOME/jmesnil.net && rake setup
RUN         mkdir $HOME/jmesnil.net/
ADD         ./Gemfile $HOME/jmesnil.net
RUN         cd $HOME/jmesnil.net && bundle install

# We need to patch awestruct to make auto generation work. On mounted volumes file
# change montoring will only work with polling
RUN        gem contents awestruct | grep auto.rb | xargs sed -i "s/^\(.*force_polling =\).*/\1 true/"

EXPOSE     4242
VOLUME     $HOME/in.relation.to
WORKDIR    $HOME/in.relation.to

CMD [ "/bin/bash" ]
