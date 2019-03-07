#!/bin/sh

if [[ ! -e result/partai.json ]]; then
  curl -k https://infopemilu.kpu.go.id/pileg2019/pencalonan/allparpol.json?_=$(date +%s) > result/partai.json
fi
partai=$(jq '.[].nomorUrut' result/partai.json)


getJson() {
  # rm -f tmp/temp_$$ 2>/dev/null
  if curl -kSs $1 -o tmp/temp_$$; then
    if [[ -e tmp/temp_$$ && $(jq -r '.[]' tmp/temp_$$ | wc -l) -gt 0 ]]; then
      cat tmp/temp_$$ >> $2
    fi
  fi
}

dapil=$(jq '.[].dapil[].id' result/dapil/dapil_dpr_wilayah_*.json)
for d in $dapil; do
  rm -f result/caleg/caleg_dpr_$d.json 2>>/dev/null
  touch result/caleg/caleg_dpr_$d.json
  for p in $partai; do
    getJson https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/$d/$p/dct?_=$(date +%s) result/caleg/caleg_dpr_$d.json
  done
done

dapil=$(jq '.[].dapil[].id' result/dapil/dapil_provinsi_wilayah_*.json)
for d in $dapil; do
  rm -f result/caleg/caleg_provinsi_$d.json 2>>/dev/null
  touch result/caleg/caleg_provinsi_$d.json
  for p in $partai; do
    getJson https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/$d/$p/dct?_=$(date +%s) result/caleg/caleg_provinsi_$d.json
  done
done

dapil=$(jq '.[].dapil[].id' result/dapil/dapil_kabupaten_wilayah_*.json)
for d in $dapil; do
  rm -f result/caleg/caleg_kabupaten_$d.json 2>>/dev/null
  touch result/caleg/caleg_kabupaten_$d.json
  for p in $partai; do
    getJson https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/$d/$p/dct?_=$(date +%s) result/caleg/caleg_kabupaten_$d.json
  done
done
