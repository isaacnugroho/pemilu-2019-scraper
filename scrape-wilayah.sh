#!/bin/sh


curl -k https://infopemilu.kpu.go.id/pileg2019/api/wilayah/cari/0?_=$(date +%s) > result/wilayah/provinsi.json

prov=$(jq '.[] | .id' result/wilayah/provinsi.json)
for p in $prov; do
  curl -k https://infopemilu.kpu.go.id/pileg2019/api/wilayah/cari/$p?_=$(date +%s) > result/wilayah/provinsi_$p.json
done
for q in result/wilayah/provinsi_*.json; do
  kab=$(jq '.[] | .id' $q)
  for r in $kab; do
    curl -k https://infopemilu.kpu.go.id/pileg2019/api/wilayah/cari/$r?_=$(date +%s) > result/wilayah/kabupaten_$r.json
  done
done
for q in result/wilayah/kabupaten_*.json; do
  kec=$(jq '.[] | .id' $q)
  for r in $kec; do
    curl -k https://infopemilu.kpu.go.id/pileg2019/api/wilayah/cari/$r?_=$(date +%s) > result/wilayah/kecamatan_$r.json
  done
done
