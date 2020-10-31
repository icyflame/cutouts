FROM ruby:2.7.0

# Javascript run time required (ExecJS)
RUN wget -q https://nodejs.org/dist/v14.15.0/node-v14.15.0-linux-x64.tar.xz
RUN tar xf node-v14.15.0-linux-x64.tar.xz
RUN rm -rf node-v14.15.0-linux-x64.tar.xz
RUN mv node-v14.15.0-linux-x64 node
RUN export PATH="$PATH:/node/bin"

# Get source and install all dependencies
COPY . /src
WORKDIR /src
RUN bundle install

ENTRYPOINT [ "/src/start-server.sh" ]
