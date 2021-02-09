#
# Use a temporary image to compile and test the libraries
#
FROM nextcloud:apache as builder

# Build and install dlib on builder

RUN apt-get update ; \
    apt-get install -y build-essential wget cmake libx11-dev libopenblas-dev

ARG DLIB_BRANCH=v19.19
RUN wget -c -q https://github.com/davisking/dlib/archive/$DLIB_BRANCH.tar.gz \
    && tar xf $DLIB_BRANCH.tar.gz \
    && mv dlib-* dlib \
    && cd dlib/dlib \
    && mkdir build \
    && cd build \
    && cmake -DBUILD_SHARED_LIBS=ON --config Release .. \
    && make \
    && make install

# Build and install PDLib on builder

ARG PDLIB_BRANCH=master
RUN apt-get install unzip
RUN wget -c -q https://github.com/matiasdelellis/pdlib/archive/$PDLIB_BRANCH.zip \
    && unzip $PDLIB_BRANCH \
    && mv pdlib-* pdlib \
    && cd pdlib \
    && phpize \
    && ./configure \
    && make \
    && make install

# Enable PDlib on builder

# If necesary take the php settings folder uncommenting the next line
# RUN php -i | grep "Scan this dir for additional .ini files"
RUN echo "extension=pdlib.so" > /usr/local/etc/php/conf.d/pdlib.ini

# Install bzip2 needed to extract models

RUN apt-get install -y libbz2-dev
RUN docker-php-ext-install bz2

# Test PDlib instalation on builder

RUN apt-get install -y git
RUN git clone https://github.com/matiasdelellis/pdlib-min-test-suite.git \
    && cd pdlib-min-test-suite \
    && make

#
# If pass the tests, we are able to create the final image.
#

FROM nextcloud:apache

# Install dependencies to image

RUN apt-get update ; \
    apt-get install -y libopenblas-base ffmpeg

# Install dlib and PDlib to image

COPY --from=builder /usr/local/lib/libdlib.so* /usr/local/lib

# If is necesary take the php extention folder uncommenting the next line
# RUN php -i | grep extension_dir
COPY --from=builder /usr/local/lib/php/extensions/no-debug-non-zts-20180731/pdlib.so /usr/local/lib/php/extensions/no-debug-non-zts-20180731/

# Enable PDlib on final image

RUN echo "extension=pdlib.so" > /usr/local/etc/php/conf.d/pdlib.ini

# Increse memory limits

RUN echo memory_limit=24576M > /usr/local/etc/php/conf.d/memory-limit.ini


# OP Cache Configuration
COPY ./config/opcache-recommended.ini /usr/local/etc/php/conf.d/