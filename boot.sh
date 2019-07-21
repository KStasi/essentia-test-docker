#!/bin/sh
# prepare env
export LD_LIBRARY_PATH="/usr/local/lib"
export WITH_ENCRYPTED_WALLET=1
essentiad_response="error:"
max_retries=100
pwd=$(pwd)

echo "---RUN ESSENTIA---"
eval "$pwd/src/divid -daemon"

echo "---ENCRYPT WALLET---"
if [ "$WITH_ENCRYPTED_WALLET" = "1" ]
then
    while [ "$essentiad_response" = "error:"  -a  $max_retries -gt 0 ]
    do
        essentiad_response=$(${pwd}/src/divi-cli encryptwallet pass 2>&1 | cut -d' ' -f 1)
        max_retries=$(($max_retries - 1))
        sleep 5
    done
fi

echo "---RUN ESSENTIA---"
eval "$pwd/src/divid -daemon"
