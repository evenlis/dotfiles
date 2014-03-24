#!/bin/bash

IN="0"
while [ "$IN" != ""  ]
do
    IN=$(echo $IN | dmenu -b -nb '#000000' -nf '#FFC300' -sb '#000000'  -sf '#FFFFFF' -p "Calc" | xargs echo | bc -l)
done
