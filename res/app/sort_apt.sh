#!/bin/bash

sort -bu apt > apt.tmp
mv apt.tmp apt
rm -rf apt.tmp
echo 'done'