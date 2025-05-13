#!/usr/bin/env fish

set var "Hello" "fish"

set var[2] "world"
set var[3] "from fish"

# expected to print in terminal 
# "Hello world from fish"
echo $var