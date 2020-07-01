FROM debian:8.7

# upgrade distro and install ocelot deps
RUN apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y make g++ libbz2-dev libtcmalloc-minimal4 wget \
                       git libev-dev libmysql++-dev libmysqld-dev

# needed as per ocelot README
RUN ln -s /usr/lib/libtcmalloc_minimal.so.4 /usr/lib/libtcmalloc.so

# build/install boost
RUN cd /tmp && wget https://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.gz && \
    tar -zxf boost_1_63_0.tar.gz && cd boost_1_63_0 && \
    ./bootstrap.sh --prefix=/usr/local && \
    ./b2 stage toolset=gcc cxxflags=-std=gnu++11 threading=multi link=shared && \
    ./b2 install toolset=gcc cxxflags=-std=gnu++11 threading=multi link=shared

# clone ocelot
RUN cd /tmp && git clone https://github.com/WhatCD/Ocelot.git

# build/install ocelot
RUN cd /tmp/Ocelot && touch aclocal.m4 configure Makefile.am Makefile.in && \
    ./configure --with-mysql-lib=/usr/lib/x86_64-linux-gnu/ --with-ev-lib=/usr/lib/x86_64-linux-gnu/ && \
    make && make install

# expose ocelot's default port
EXPOSE 34000

# load in the start script
ADD start.sh /start.sh
RUN chmod +x /start.sh

# start ocelot
CMD ["/start.sh"]
