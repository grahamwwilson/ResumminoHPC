#!/bin/sh
#
# Download suitable pdf sets from LHAPDF and extract in location expected by Resummino. 
# For example ./pdfget.sh CT10
# Some of these can be very large. 
# Care should likely be taken that appropriate choices of LO and NLO pdf sets are specified
#
# IMPORTANT INFORMATION ABOUT PDF SETS
#
# LHAPDF no longer bundles PDF set data in the package tarball.
# The sets are instead all stored online at
#   http://lhapdfsets.web.cern.ch/lhapdfsets/current/
# and you should install those that you wish to use into
#   /home/graham/Resummino/resummino-releases/build/lhapdf-prefix/share/LHAPDF
#
# The downloadable PDF sets are packaged as tarballs, which
# must be expanded to be used. The simplest way to do this is with
# the 'lhapdf' script, e.g. to install the CT10nlo PDF set:
#  lhapdf install CT10nlo
# The same effect can be achieved manually with, e.g.:
#  wget http://lhapdfsets.web.cern.ch/lhapdfsets/current/CT10nlo.tar.gz -O- | tar xz -C /home/graham/Resummino/resummino-releases/build/lhapdf-prefix/share/LHAPDF
# The latter worked for me.

PDFSETNAME=${1:-CT10}

wget http://lhapdfsets.web.cern.ch/lhapdfsets/current/${PDFSETNAME}.tar.gz -O- | tar xz -C /home/graham/Resummino/resummino-releases/build/lhapdf-prefix/share/LHAPDF

exit
