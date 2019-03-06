#!/bin/sh

prov=$(jq '.[] | .id' result/wilayah/provinsi.json)
for p in $prov; do
  curl -k https://infopemilu.kpu.go.id/pileg2019/api/geojson/get/$p/0?_=$(date +%s) > result/geo/dapil_dpr_geojson_$p.json
  curl -k https://infopemilu.kpu.go.id/pileg2019/api/dapil/$p/0?_=$(date +%s) > result/dapil/dapil_dpr_wilayah_$p.json
done

for p in $prov; do
  curl -k https://infopemilu.kpu.go.id/pileg2019/api/geojson/get/$p/1?_=$(date +%s) > result/geo/dapil_provinsi_geojson_$p.json
  curl -k https://infopemilu.kpu.go.id/pileg2019/api/dapil/$p/1?_=$(date +%s) > result/dapil/dapil_provinsi_wilayah_$p.json
done

kab=$(jq '.[] | .id' result/wilayah/provinsi_*.json)
for p in $kab; do
  curl -k https://infopemilu.kpu.go.id/pileg2019/api/geojson/get/$p/2?_=$(date +%s) > result/geo/dapil_kabupaten_geojson_$p.json
  curl -k https://infopemilu.kpu.go.id/pileg2019/api/dapil/$p/2?_=$(date +%s) > result/dapil/dapil_kabupaten_wilayah_$p.json
done
