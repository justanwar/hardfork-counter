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

# Create temp file. Clear if exist
touch temp.txt
> temp.txt

# HF block for Spark Name Transfer
hf_block_sn=1205100

# Block at which Lelantus redemption stops
LELANTUS_GRACEFUL_PERIOD=1223500

curr_block=$(firo-cli getblockcount)
dist_sn=$(($hf_block_sn-$curr_block))
dist_lela=$(($LELANTUS_GRACEFUL_PERIOD-$curr_block))

if [ $dist_sn -le 0 ]; then
    echo "Spark Name hard fork block reached." >> temp.txt
else
    echo "Spark Name hard fork block is $hf_block_sn, $dist_sn blocks to go." >> temp.txt
    # Assuming average of 150 seconds per block (2.5 minutes)
    seconds=$((dist_sn*150))

    date -u -d @${seconds} +"In $(($seconds/3600/24)) days %H hours %M minutes." >> temp.txt
 
fi

if [ $dist_lela -le 0 ]; then
    echo "Lelantus redemption period ended." >> temp.txt
else
    echo "Lelantus redemption ends at $LELANTUS_GRACEFUL_PERIOD, $dist_lela blocks to go." >> temp.txt
    seconds_lela=$((dist_lela*150))

    date -u -d @${seconds_lela} +"In $(($seconds_lela/3600/24)) days %H hours %M minutes." >> temp.txt
fi
