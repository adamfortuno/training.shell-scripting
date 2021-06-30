#!/bin/bash

line_number=1

ls /etc | while read line
do
    echo "${line_number}: ${line}"
    ((line_number++))
done