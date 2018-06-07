#!/bin/bash
pass='number1 number12 number13 number14 number15 number16'
chk='number14'
max=0
for i in $pass ; do
    let max=$max+1
done
index=0
strdone="#########################"
strtodo="-------------------------"
for i in $pass ; do
    let index=$index+1
    if [ "$i" == "$chk" ]; then
        echo ""
        echo ' Found ^_^'
    else
        lendone=$((index * ${#strdone} / max))
        let lentodo=${#strdone}-$lendone
        percent=$((index * 100 / max))
        echo -ne "[#${strdone:0:$lendone}${strtodo:0:$lentodo}] $percent%\r"
    fi
    sleep 1
done
echo ""