#!/bin/bash

fifo_file=/tmp/get_uniq
mkfifo $fifo_file

number=1
while :
do
    echo $number > $fifo_file
    ((number++))
    sleep 1
done

