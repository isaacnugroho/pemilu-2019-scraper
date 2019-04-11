#!/bin/sh

getJson() {
  if curl -k "$1" -o /tmp/temp_$$; then
    if [[ -f /tmp/temp_$$ && $(jq -r '.[]' /tmp/temp_$$ | wc -l) -gt 0 ]]; then
      cat /tmp/temp_$$ >> $2
    else
      echo $1 $2 >> scrape-geo-error.txt
    fi
  fi
}

wil=$(jq '.[] | .id' result/dapil/dapil_*.json)
for p in $wil; do
  if [[ ! -f result/geo/dapil_geojson_$p.json ]]; then
    getJson https://infopemilu.kpu.go.id/pileg2019/api/geojson/get/$p/0?_=$(date +%s) result/geo/dapil_geojson_$p.json
  fi
done
