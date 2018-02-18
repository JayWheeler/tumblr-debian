# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for tumblr in 
#		a Debian 9.3 docker container.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 0.3.0
# @copyright © 2017, 2018. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package tumblr
# @subpackage Dockerfile
#
# =========================================================================
#
#	Copyright © 2017, 2018. EarthWalk Software
#	Licensed under the Academic Free License, version 3.0.
#
#	Refer to the file named License.txt provided with the source,
#	or from
#
#		http://opensource.org/licenses/academic.php
#
# =========================================================================
# =========================================================================

FROM earthwalksoftware/debian-base:2.0.2

MAINTAINER Jay Wheeler <earthwalksoftware@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# =========================================================================

ENV LMSBUILD_DOCKER="jaywheeler/tumblr:0.3.0"
ENV LMSBUILD_PACKAGE="tumblr v. 0.0.7"

ENV LMSOPT_QUIET=0
ENV TUMBLR_CAT=""

# =========================================================================

COPY scripts/. /

RUN echo "Building ${LMSBUILD_DOCKER} (${LMSBUILD_PACKAGE})" \
 && mkdir -p /etc/BUILDS/ \
 && printf "${LMSBUILD_DOCKER} (${LMSBUILD_PACKAGE}), %s @ %s\n" `date '+%Y-%m-%d'` `date '+%H:%M:%S'` > /etc/BUILDS/tumblr \
 && chmod -R +x /usr/local/bin/* \
 && apt-get -y update \
 && apt-get -y upgrade \
 && apt-get -y install \
               bash-completion \
               bash-doc 

# =========================================================================

VOLUME /tumblr-lists
VOLUME /tumblr-target

# =========================================================================

ENTRYPOINT ["/my_init","--quiet"]
CMD ["tumblr"]
