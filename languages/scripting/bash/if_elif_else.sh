#!/bin/bash

age=17
if [ $age -ge 18 ] && [ $age -lt 65];
then 
    echo "You are an adult of working age."
elif [ $age -ge 13 ] || [ $age -gt 65 ];
    echo " You are a eligible for a discounted ticket."
else 
    echo "Your code is wrong."
fi

