#!/bin/sh

getJson() {
  if curl -k "$1" -o /tmp/temp_$$; then
    if [[ -f /tmp/temp_$$ && $(jq -r '.[]' /tmp/temp_$$ | wc -l) -gt 0 ]]; then
      cat /tmp/temp_$$ >> $2
    else
      echo $1 $2 >> scrape-dapil-error.txt
    fi
  fi
}

prov=$(jq '.[] | .id' result/wilayah/provinsi.json)
for p in $prov; do
  rm -f result/dapil/dapil_dpr_wilayah_$p.json 2>/dev/null
  getJson https://infopemilu.kpu.go.id/pileg2019/api/dapil/$p/0?_=$(date +%s) result/dapil/dapil_dpr_wilayah_$p.json
done

for p in $prov; do
  rm -f result/dapil/dapil_provinsi_wilayah_$p.json 2>/dev/null
  getJson https://infopemilu.kpu.go.id/pileg2019/api/dapil/$p/1?_=$(date +%s) result/dapil/dapil_provinsi_wilayah_$p.json
done

kab=$(jq '.[] | .id' result/wilayah/provinsi_*.json)
for p in $kab; do
  rm -f result/dapil/dapil_kabupaten_wilayah_$p.json 2>/dev/null
  getJson https://infopemilu.kpu.go.id/pileg2019/api/dapil/$p/2?_=$(date +%s) result/dapil/dapil_kabupaten_wilayah_$p.json
done
