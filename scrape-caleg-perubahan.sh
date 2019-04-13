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
      echo $1 $2 >> scrape-caleg-perubahan-error.txt
    fi
  fi
}

dapil=$(jq '.[].dapil[].id' result/dapil/dapil_dpr_wilayah_*.json)
for d in $dapil; do
  for p in $partai; do
    if [[ ! -f result/caleg/caleg_dpr_perubahan_${d}_${p}.json ]]; then
      getJson https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/${d}/${p}/perubahan-dct?_=$(date +%s) result/caleg/caleg_dpr_perubahan_${d}_${p}.json
    fi
  done
done

dapil=$(jq '.[].dapil[].id' result/dapil/dapil_provinsi_wilayah_*.json)
for d in $dapil; do
  for p in $partai; do
    if [[ ! -f result/caleg/caleg_provinsi_perubahan_${d}_${p}.json ]]; then
      getJson https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/${d}/${p}/perubahan-dct?_=$(date +%s) result/caleg/caleg_provinsi_perubahan_${d}_${p}.json
    fi
  done
done

dapil=$(jq '.[].dapil[].id' result/dapil/dapil_kabupaten_wilayah_*.json | sort)
for d in $dapil; do
  for p in $partai; do
    if [[ ! -f result/caleg/caleg_kabupaten_perubahan_${d}_${p}.json ]]; then
      getJson https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/${d}/${p}/perubahan-dct?_=$(date +%s) result/caleg/caleg_kabupaten_perubahan_${d}_${p}.json
    fi
  done
done
