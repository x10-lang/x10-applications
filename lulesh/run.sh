#!/bin/sh

for exec in wlog wolog
do
#  for type in c++ x10
  for type in c++
  do
    dir=result_$type.$exec
    mkdir -p $dir
    for j in `seq 1 3`
    do
	rm -f /tmp/lulesh*output
	file=$dir/log_$type_$exec.$j
	echo $file
	./$type/lulesh.$exec >$file
    done
  done
done
