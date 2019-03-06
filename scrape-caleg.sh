#!/bin/sh

curl -k https://infopemilu.kpu.go.id/pileg2019/pencalonan/allparpol.json?_=$(date +%s) > result/partai.json

partai=$(jq '.[].nomorUrut' result/partai.json)

dapil=$(jq '.[].dapil[].id' result/dapil/dapil_dpr_wilayah_*.json)
for d in $dapil; do
  rm -f result/caleg/caleg_dpr_$d.json
  for p in $partai; do
    echo https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/$d/$p/dct?_=$(date +%s)
    curl -k https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/$d/$p/dct?_=$(date +%s) >> result/caleg/caleg_dpr_$d.json
  done
done

dapil=$(jq '.[].dapil[].id' result/dapil/dapil_provinsi_wilayah_*.json)
for d in $dapil; do
  rm -f result/caleg/caleg_provinsi_$d.json
  for p in $partai; do
    echo https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/$d/$p/dct?_=$(date +%s)
    curl -k https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/$d/$p/dct?_=$(date +%s) >> result/caleg/caleg_provinsi_$d.json
  done
done

dapil=$(jq '.[].dapil[].id' result/dapil/dapil_kabupaten_wilayah_*.json)
for d in $dapil; do
  rm -f result/caleg/caleg_kabupaten_$d.json
  for p in $partai; do
    echo https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/$d/$p/dct?_=$(date +%s)
    curl -k https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/$d/$p/dct?_=$(date +%s) >> result/caleg/caleg_kabupaten_$d.json
  done
done
