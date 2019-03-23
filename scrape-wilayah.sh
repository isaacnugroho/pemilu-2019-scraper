#!/bin/sh

getJson() {
  if curl -k "$1" -o /tmp/temp_$$; then
    if [[ -f /tmp/temp_$$ && $(jq -r '.[]' /tmp/temp_$$ | wc -l) -gt 0 ]]; then
      cat /tmp/temp_$$ >> $2
    else
      echo $1 $2 >> scrape-wilayah-error.txt
    fi
  fi
}

rm -f result/wilayah/provinsi.json 2>/dev/null
getJson https://infopemilu.kpu.go.id/pileg2019/api/wilayah/cari/0?_=$(date +%s) result/wilayah/provinsi.json

prov=$(jq '.[] | .id' result/wilayah/provinsi.json)
for p in $prov; do
  rm -f result/wilayah/provinsi_$p.json 2>/dev/null
  getJson https://infopemilu.kpu.go.id/pileg2019/api/wilayah/cari/$p?_=$(date +%s) result/wilayah/provinsi_$p.json
done
for q in result/wilayah/provinsi_*.json; do
  kab=$(jq '.[] | .id' $q)
  for r in $kab; do
    rm -f result/wilayah/kabupaten_$r.json 2>/dev/null
    getJson https://infopemilu.kpu.go.id/pileg2019/api/wilayah/cari/$r?_=$(date +%s) result/wilayah/kabupaten_$r.json
  done
done
for q in result/wilayah/kabupaten_*.json; do
  kec=$(jq '.[] | .id' $q)
  for r in $kec; do
    rm -f result/wilayah/kecamatan_$r.json 2>/dev/null
    getJson  https://infopemilu.kpu.go.id/pileg2019/api/wilayah/cari/$r?_=$(date +%s) result/wilayah/kecamatan_$r.json
  done
done
