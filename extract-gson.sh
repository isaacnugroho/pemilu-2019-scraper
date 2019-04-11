#!/bin/bash

i=0
for p in result/geo/dapil_geojson_dpr_*.json; do
  v=$(echo $p | grep -oE '[0-9]+')
  echo $v
  if [[ i -eq 0 ]]; then
    jq -r --argjson dapilId "$v" '[.features[].properties|{ idDapil: $dapilId, id_wilayah, tingkatWilayah, id_provinsi, id_kabkota, id_kecamatan, jumlahPenduduk, alokasiKursi}] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/dapil_geojson_dpr.csv && i=1
  else
    jq -r --argjson dapilId "$v" '[.features[].properties|{ idDapil: $dapilId, id_wilayah, tingkatWilayah, id_provinsi, id_kabkota, id_kecamatan, jumlahPenduduk, alokasiKursi}] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil_geojson_dpr.csv

  fi
done
i=0
for p in result/geo/dapil_geojson_provinsi_*.json; do
  v=$(echo $p | grep -oE '[0-9]+')
  echo $v
  if [[ i -eq 0 ]]; then
    jq -r --argjson dapilId "$v" '[.features[].properties|{ idDapil: $dapilId, id_wilayah, tingkatWilayah, id_provinsi, id_kabkota, id_kecamatan, jumlahPenduduk, alokasiKursi}] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/dapil_geojson_provinsi.csv && i=1
  else
    jq -r --argjson dapilId "$v" '[.features[].properties|{ idDapil: $dapilId, id_wilayah, tingkatWilayah, id_provinsi, id_kabkota, id_kecamatan, jumlahPenduduk, alokasiKursi}] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil_geojson_provinsi.csv

  fi
done
i=0
for p in result/geo/dapil_geojson_kabupaten_*.json; do
  v=$(echo $p | grep -oE '[0-9]+')
  echo $v
  if [[ i -eq 0 ]]; then
    jq -r --argjson dapilId "$v" '[.features[].properties|{ idDapil: $dapilId, id_wilayah, tingkatWilayah, id_provinsi, id_kabkota, id_kecamatan, jumlahPenduduk, alokasiKursi}] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/dapil_geojson_kabupaten.csv && i=1
  else
    jq -r --argjson dapilId "$v" '[.features[].properties|{ idDapil: $dapilId, id_wilayah, tingkatWilayah, id_provinsi, id_kabkota, id_kecamatan, jumlahPenduduk, alokasiKursi}] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil_geojson_kabupaten.csv

  fi
done
