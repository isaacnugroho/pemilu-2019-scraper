#!/bin/sh

getJson() {
  if curl -k "$1" -o /tmp/temp_$$; then
    if [[ -f /tmp/temp_$$ && $(jq -r '.' /tmp/temp_$$) ]]; then
      cat /tmp/temp_$$ >> $2
    else
      echo $1 $2 >> scrape-dapil-error.txt
    fi
  fi
}

for p in 8688 6729 25072 25824 25833 25886 25924 25989 26065 32547 41501 51327 51550 53106 53650 53972 60255 60372 61929 76995 79826 80309 81007 82154 83194; do
  rm -f result/dapil/dapil_kabupaten_wilayah_$p.json 2>/dev/null
  getJson https://infopemilu.kpu.go.id/pileg2019/api/dapil/$p/2?_=$(date +%s) result/dapil/dapil_kabupaten_wilayah_$p.json
done
