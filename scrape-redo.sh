#!/bin/sh

getJson() {
  if curl -k "$1" -o /tmp/temp_$$; then
    # do not check empty && $(jq -r '.[]' /tmp/temp_$$ | wc -l) -gt 0 
    if [[ -f /tmp/temp_$$ ]]; then
      cat /tmp/temp_$$ >> $2
    else
      echo $1 $2 >> scrape-redo-error.txt
    fi
  fi
}

file="$1"
if [[ -f $file ]]; then
  while read -r src dst
  do
    if [[ ! -f $dst ]]; then
      getJson $src $dst
    fi  
  done <"$file"
fi

