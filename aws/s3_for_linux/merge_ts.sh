#!/bin/bash
for i in `ls *.ts | sort -V`; do echo "file $i"; done >> filelist.txt
ffmpeg -f concat -i filelist.txt -c copy output.mp4
