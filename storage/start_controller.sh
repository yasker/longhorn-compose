#!/bin/bash

if [ -z $1 ]
then
    echo Failed to find replica service name
    exit 1
fi

replica_service=$1
hosts=`/usr/bin/dig +noall +answer +short $replica_service`
if [ $? -ne 0 ]
then
    echo Fail to get DNS record for $replica_service
    exit 1
fi
host_args=""
for host in $hosts
do
    host_args=$host_args"--host $host "
done
if [ -z "$host_args" ]
then
    echo Cannot get any DNS record for $replica_service
    exit 1
fi
echo "Calling controller with arguments: $host_args"
/usr/local/bin/controller $host_args
