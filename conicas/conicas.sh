#!/bin/bash

template=conicas-template.tex
file=conicas.list
vars=(QUADA QUADB QUADC QUADD QUADE QUADF FSET FMIN XVAL YVAL)

iter=0
cat $file | while read line
do
  line=($line)
  output=`cat -E $template`
  for i in $(seq 0 $((${#vars[@]}-1)))
  do
    var=${vars[i]}
    val=${line[i]}
    output=$(echo $output | sed "s/$var/$val/")
  done
  echo $output | sed 's/\$ /\n/g' > tmp.tex
  latexmk -pdf tmp.tex
  mv tmp.pdf iter$iter.pdf
done
latexmk -c tmp
