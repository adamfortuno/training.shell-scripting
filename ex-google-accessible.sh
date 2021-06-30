#!/bin/bash

HOST="google.com"

ping -c 1 "$HOST"

if [ "$?" -eq "0" ]
then
    echo "Google is accessible."
else
    echo "Google is not accessible."
fi