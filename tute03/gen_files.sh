#!/bin/dash

mkdir "q$1" || exit
cd "q$1" || exit
touch "q$1.s"
touch "q$1"_simplified.c
touch "q$1"_reference.c
echo "Files made for question $1"
