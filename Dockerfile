FROM debian:stretch

MAINTAINER Julian Caba <julian.caba@uclm.es>

WORKDIR /test

RUN apt-get update && apt-get install -y make libncurses5 libx11-6 libc6-dev python3.4 python3-jinja2 python3-zeroc-ice python3-nose
ENV LM_LICENSE_FILE=1900@atclab.esi.uclm.es:1901@atclab.esi.uclm.es:1702@atclab.esi.uclm.es

COPY . /test/

