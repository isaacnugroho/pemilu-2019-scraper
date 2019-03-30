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

wil=$(jq '.[] | .id' result/dapil/dapil_dpr_wilayah_*.json)
for p in $wil; do
  rm -f result/geo/dapil_dpr_geojson_$p.json 2>/dev/null
  getJson https://infopemilu.kpu.go.id/pileg2019/api/geojson/get/$p/0?_=$(date +%s) result/geo/dapil_dpr_geojson_$p.json
done

wil=$(jq '.[] | .id' result/dapil/dapil_provinsi_wilayah_*.json)
for p in $wil; do
  rm -f result/geo/dapil_provinsi_geojson_$p.json 2>/dev/null
  getJson https://infopemilu.kpu.go.id/pileg2019/api/geojson/get/$p/1?_=$(date +%s) result/geo/dapil_provinsi_geojson_$p.json
done

wil=$(jq '.[] | .id' result/dapil/dapil_kabupaten_wilayah_*.json)
for p in $wil; do
  rm -f result/geo/dapil_kabupaten_geojson_$p.json 2>/dev/null
  getJson https://infopemilu.kpu.go.id/pileg2019/api/geojson/get/$p/2?_=$(date +%s) result/geo/dapil_kabupaten_geojson_$p.json
done
