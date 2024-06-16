#!/bin/bash

number=$1

od -A n -v -t u1 $2 | tr -s " " "," | while read -r line
do
    echo "$number DATA ${line:1}"
    ((number++))
    
done
