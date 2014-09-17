FROM marxin/opensuse-docker
MAINTAINER Martin Liška

WORKDIR /abuild

RUN wget --no-check-certificate https://github.com/marxin/gcc/archive/docker.zip
RUN unzip docker.zip

WORKDIR /abuild/gcc-docker
RUN mkdir objdir 
WORKDIR objdir
RUN ../configure --enable-languages=c,c++ --disable-bootstrap --disable-multilib --enable-checking=release --disable-libsanitizer --prefix=/abuild/bin/gcc &&  make -j$(nproc) && make install && rm * -rf
