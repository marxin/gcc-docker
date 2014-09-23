FROM marxin/opensuse-docker
MAINTAINER Martin Liška

WORKDIR /abuild

RUN ld --version
RUN which ld

RUN wget --no-check-certificate https://github.com/marxin/gcc/archive/docker.zip?v=1
RUN unzip docker.zip

WORKDIR /abuild/gcc-docker
RUN mkdir objdir 
WORKDIR objdir
RUN ../configure --enable-languages=c,c++ --disable-bootstrap --disable-multilib --enable-checking=release --disable-libsanitizer --prefix=/abuild/bin/gcc &&  make -j$(nproc) && make install && rm * -rf

RUN mkdir /abuild/bin/binutils/lib/bfd-plugins/ && ln -s /abuild/bin/gcc/libexec/gcc/x86_64-unknown-linux-gnu/5.0.0/liblto_plugin.so /abuild/bin/binutils/lib/bfd-plugins/

ENV PATH /abuild/bin/gcc/bin:$PATH
ENV LD_LIBRARY_PATH /abuild/bin/gcc/bin:$LD_LIBRARY_PATH
