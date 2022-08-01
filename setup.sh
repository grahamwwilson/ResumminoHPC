#!/bin/bash
#
# Do source ./setup.sh to make this work
#

# module load boost
# module load cmake

echo $LD_LIBRARY_PATH

# Needed for GSL library
WORKG=/panfs/pfs.local/work/wilson/gwwilson
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORKG/lib

exit
