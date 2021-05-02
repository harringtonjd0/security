#!/bin/bash

i=1
while true
do 
	base64 -d output$i.txt > output$(($i+1)).txt || exit
	i=$(($i+1))
done

