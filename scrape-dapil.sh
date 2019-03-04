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

caleg=$(jq '.[].dapil[].id' result/dapil/dapil_dpr_wilayah_*.json)
for c in $caleg; do
  curl -k https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/$c/calonDct.json?_=$(date +%s) > result/caleg/dapil_dpr_caleg_$c.json
done

caleg=$(jq '.[].dapil[].id' result/dapil/dapil_provinsi_wilayah_*.json)
for c in $caleg; do
  curl -k https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/$c/calonDct.json?_=$(date +%s) > result/caleg/dapil_provinsi_caleg_$c.json
done

caleg=$(jq '.[].dapil[].id' result/dapil/dapil_kabupaten_wilayah_*.json)
for c in $caleg; do
  curl -k https://infopemilu.kpu.go.id/pileg2019/pencalonan/pengajuan-calon/$c/calonDct.json?_=$(date +%s) > result/caleg/dapil_kabupaten_caleg_$c.json
done
