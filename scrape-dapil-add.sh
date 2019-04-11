#!/bin/sh

getJson() {
  if curl -k "$1" -o /tmp/temp_$$; then
    if [[ -f /tmp/temp_$$ && $(jq -r '.' /tmp/temp_$$) ]]; then
      cat /tmp/temp_$$ >> $2
    else
      echo $1 $2 >> scrape-dapil-add-error.txt
    fi
  fi
}

for p in 6729 25072 32547 41501 51327 51550 53106 53650 53972 60255 60372 61929 76995 79826 80309 81007 82154 83194 ; do
  if [[ ! -f result/dapil/dapil_wilayah_$p.json ]]; then
    getJson https://infopemilu.kpu.go.id/pileg2019/api/dapil/$p/2?_=$(date +%s) result/dapil/dapil_wilayah_$p.json
  fi
done
