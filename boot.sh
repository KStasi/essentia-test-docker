#!/bin/sh
# prepare lib
export LD_LIBRARY_PATH="/usr/local/lib"

echo "---RUN ESSENTIA---"
/home/server_admin/essentia/src/divid -daemon

echo "---ENCRYPT WALLET---"
essentiad_response="error:"
max_retries=100
while [ "$essentiad_response" = "error:"  -a  $max_retries -gt 0 ]
do
    essentiad_response=$(/home/server_admin/essentia/src/divi-cli encryptwallet pass 2>&1 | cut -d' ' -f 1)
    max_retries=$(($max_retries - 1))
    sleep 5
done

echo "---RUN ESSENTIA---"
/home/server_admin/essentia/src/divid