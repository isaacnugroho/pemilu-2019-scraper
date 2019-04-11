#!/bin/bash

i=0
for p in result/dapil/dapil_*.json; do
  echo $p
  if [[ i -eq 0 ]]; then
    jq -r '[.[]|{ id, idWilayah, maxAlokasiKursi, mean, minAlokasiKursi, stdDev, tingkat}] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/dapil_alokasi.csv

    jq -r '[.[] | .id as $refId |.dapil[] | { id, $refId, idWilayah, nama, noDapil, tingkat, totalAlokasiKursi, jumlahPenduduk }] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/dapil.csv

    jq -r '[.[] | .id as $refId | .dapil[] | .tingkat as $tingkat | .wilayah[] | { $refId, idDapil, idWilayah, namaWilayah, urutanWilayahDapil, $tingkat }] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/dapil_map.csv
    i=1
  else
    jq -r '[.[]|{ id, idWilayah, maxAlokasiKursi, mean, minAlokasiKursi, stdDev, tingkat}] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil_alokasi.csv

    jq -r '[.[] | .id as $refId |.dapil[] | { id, $refId, idWilayah, nama, noDapil, tingkat, totalAlokasiKursi, jumlahPenduduk }] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil.csv

    jq -r '[.[] | .id as $refId | .dapil[] | .tingkat as $tingkat | .wilayah[] | { $refId, idDapil, idWilayah, namaWilayah, urutanWilayahDapil, $tingkat }] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil_map.csv
  fi
done

