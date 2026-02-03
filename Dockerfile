## Emacs, make this -*- mode: sh; -*-

## start with the Docker 'base R' Debian-based image
# https://hub.docker.com/r/rocker/r-devel-san
FROM rocker/r-devel-san:latest

LABEL maintainer="Florian Schwendinger"

## Remain current
RUN apt-get update -qq \
	&& apt-get dist-upgrade -y

## From the Build-Depends of the Debian R package, plus subversion
RUN apt-get update -qq \
	&& apt-get install -t unstable -y --no-install-recommends \
	build-essential \
	cmake \
	&& rm -rf /var/lib/apt/lists/* \
	&& R -q -e 'install.packages(c("Rcpp", "checkmate", "tinytest"))'

ENV ASAN_OPTIONS 'alloc_dealloc_mismatch=0:detect_leaks=0:detect_odr_violation=0' 
ENV UBSAN_OPTIONS 'print_stacktrace=1'
ENV RJAVA_JVM_STACK_WORKAROUND 0
ENV RGL_USE_NULL true
ENV R_DONT_USE_TK true

