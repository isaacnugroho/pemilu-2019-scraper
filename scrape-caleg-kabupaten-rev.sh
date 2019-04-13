#!/bin/sh

if [[ ! -e result/partai.json ]]; then
  curl -k https://infopemilu.kpu.go.id/pileg2019/pencalonan/allparpol.json?_=$(date +%s) > result/partai.json
fi
partai=$(jq '.[].nomorUrut' result/partai.json)

getJson() {
  if curl -k "$1" -o /tmp/temp_$$; then
    if [[ -f /tmp/temp_$$ && $(jq -r '.' /tmp/temp_$$ 2>/dev/null) ]]; then
      cat /tmp/temp_$$ >> $2
    else
      echo $1 $2 >> scrape-caleg-kabupaten-error.txt
    fi
  fi
}

dapil=$(jq '.[].dapil[].id' result/dapil/dapil_kabupaten_wilayah_*.json | sort -r)
for d in $dapil; do
  for p in $partai; do
    if [[ ! -f result/caleg/caleg_kabupaten_${d}_${p}.json ]]; then
      getJson https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/${d}/${p}/dct?_=$(date +%s) result/caleg/caleg_kabupaten_${d}_${p}.json
    fi
  done
done
