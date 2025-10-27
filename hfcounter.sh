#!/bin/bash

# Calculates and shows block/time remaining until specified hard fork block
# Requires firod+firo-cli on system
# Remote calls will be implemented later

# Debugging
# set -x

#if [[ ! -f .firo/firod.pid ]]; then
#    red "Error: Firod is not running."
#    exit
#fi

# HF block for Spark Name Transfer
hf_block_sn=1205100

curr_block=$(firo-cli getblockcount)
dist_sn=$(($hf_block_sn-$curr_block))

if [ $dist_sn -le 0 ]; then
    echo "HF block reached."
    exit
else
    echo "HF block is $hf_block_sn, $dist_sn blocks to go."
    # Assuming average of 150 seconds per block (2.5 minutes)
    seconds=$((dist*150))

    date -u -d @${seconds} +"In $(($seconds/3600/24)) days %H hours %M minutes."
fi
