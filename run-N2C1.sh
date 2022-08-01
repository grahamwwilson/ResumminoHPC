#!/bin/bash
# 
# run-N2C1.sh
#
# Here we edit the SLHA file on the fly.
#
# Please change E-mail to your own E-mail or turn that feature off!
#
#SBATCH --job-name=resummino          # Job name
#SBATCH --partition=sixhour           # Partition Name (Required)
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=gwwilson@ku.edu   # Where to send mail	
#SBATCH --nodes=1 --ntasks=1          # Run on a single CPU
#SBATCH --mem=1g                      # Job memory request
#SBATCH --time=0-00:60:00             # Time limit days-hrs:min:sec
#SBATCH --array=1-1                   # Job array length
#SBATCH --output=resummino_%A_%a.log  # Standard output and error log
#SBATCH --error=resummino_%A_%a.err   # Standard output and error log

# Note currently the batch job does NOT yet change the center-of-mass energy from 13 TeV
ECM=${1:-13000}

pwd
CWD=$(pwd)
hostname
date
echo $HOME
echo $WORK
echo "SLURM_ARRAY_JOB_ID: "${SLURM_ARRAY_JOB_ID}
echo "SLURM_ARRAY_TASK_ID: "${SLURM_ARRAY_TASK_ID}

# Main directory for the git based code etc.
# On HPC this should be where you cloned the git repository ResumminoHPC 
# It is assumed here that you cloned into your $WORK directory (/panfs/pfs.local/work/wilson/$USER
GITDIR=$WORK/ResumminoHPC
SLHADIR=$WORK/MyProspinoStuff/SLHAFiles
# Directory where the executable resides
EXEDIR=/panfs/pfs.local/work/wilson/gwwilson/Resummino/ResumminoInstall/bin

MN2=${2:-250.0}
MC1=${3:-235.0}
MN1=${4:-220.0}
SLHA=Higgsinos_${MN2}-${MC1}-${MN1}
NMN2=${MN2}E+00
NMC1=${MC1}E+00
NMN1=${MN1}E+00
echo 'New masses = '${NMN2},${NMC1},${NMN1}

PROCESS=${5:-N2C1Plus}
# Directory to run batch job from (Batch Run DIRectory)
BRDIR=$WORK/ResumminoOut/${PROCESS}-${SLHA}-${ECM}-Job-${SLURM_ARRAY_JOB_ID}-${SLURM_ARRAY_TASK_ID}

# Make sure GSL is found
echo ${LD_LIBRARY_PATH}
# Adding GSL to library path
echo 'Adding GSL to library path'
# Needed for GSL library
WORKG=/panfs/pfs.local/work/wilson/gwwilson
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$WORKG/lib
echo ${LD_LIBRARY_PATH}

mkdir ${BRDIR}
cd ${BRDIR}

echo 'Now in BRDIR'
pwd

SLHAFILE=myslha.in

# First copy over template slha file to batch directory
cp ${SLHADIR}/higgsino_slha_C1C1_V2.in ${SLHA}.slha

# Now replace the values appropriately
sed -i -e "s/{MN2}/${NMN2}/g" -e "s/{MC1}/${NMC1}/g" -e "s/{MN1}/${NMN1}/g" ${SLHA}.slha

if [ ! -e ${SLHAFILE} ]
then
   ln -s ${SLHA}.slha ${SLHAFILE}
fi

cp ${GITDIR}/${PROCESS}.in My-${PROCESS}.in

# Check whether all shared object libraries are resolved
ldd ${EXEDIR}/resummino

${EXEDIR}/resummino My-${PROCESS}.in >job.out

cd ${CWD}

date
echo 'Job completed'

exit
