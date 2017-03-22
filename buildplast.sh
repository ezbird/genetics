#!/bin/bash

let COUNTD=3
while [ $COUNTD -lt 25 ]; do
	let COUNTD=$COUNTD+1
	bash runsoap.sh 21 $COUNTD > results/results-d$COUNTD-225.txt
done


