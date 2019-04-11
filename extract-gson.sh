#!/bin/bash

i=0
for p in result/geo/dapil_*.json; do
  v=$(echo $p | grep -oE '[0-9]+')
  echo $v
  if [[ i -eq 0 ]]; then
    jq -r --argjson dapilId "$v" '[.features[].properties|{ idDapil: $dapilId, id_wilayah, tingkatWilayah, id_provinsi, id_kabkota, id_kecamatan, jumlahPenduduk, alokasiKursi}] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/dapil_geojson.csv && i=1
  else
    jq -r --argjson dapilId "$v" '[.features[].properties|{ idDapil: $dapilId, id_wilayah, tingkatWilayah, id_provinsi, id_kabkota, id_kecamatan, jumlahPenduduk, alokasiKursi}] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil_geojson.csv

  fi
done
