#!/bin/sh
#
# launch-N2C1
#
# Launch two batch jobs for N2C1 production
# 

sbatch $WORK/ResumminoHPC/run-N2C1.sh 13000 250.0 225.0 200.0 N2C1Plus
sbatch $WORK/ResumminoHPC/run-N2C1.sh 13000 250.0 225.0 200.0 N2C1Minus

exit
