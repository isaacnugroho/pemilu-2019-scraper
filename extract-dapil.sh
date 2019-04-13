#!/bin/bash

i=0
for p in result/dapil/dapil_*.json; do
  echo $p
  if [[ i -eq 0 ]]; then
    jq -r '[.[]|{ id, idWilayah, maxAlokasiKursi, mean, minAlokasiKursi, stdDev, tingkat}] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/dapil_alokasi.csv

    jq -r '[.[] | .id as $refId |.dapil[] | { id, $refId, idWilayah, nama, noDapil, tingkat, totalAlokasiKursi, jumlahPenduduk }] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/dapil.csv

    jq -r '[.[] | .dapil[] | .tingkat as $tingkat | .nama as $namaDapil | .idWilayah as $idWilayah | .wilayah[] | .idWilayah as $subWilayah | { idDapil, $namaDapil, $idWilayah, $subWilayah, namaWilayah, urutanWilayahDapil, $tingkat }] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/dapil_map.csv
    i=1
  else
    jq -r '[.[]|{ id, idWilayah, maxAlokasiKursi, mean, minAlokasiKursi, stdDev, tingkat}] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil_alokasi.csv

    jq -r '[.[] | .id as $refId |.dapil[] | { id, $refId, idWilayah, nama, noDapil, tingkat, totalAlokasiKursi, jumlahPenduduk }] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil.csv

    jq -r '[.[] | .dapil[] | .tingkat as $tingkat | .nama as $namaDapil | .idWilayah as $idWilayah | .wilayah[] | .idWilayah as $subWilayah | { idDapil, $namaDapil, $idWilayah, $subWilayah, namaWilayah, urutanWilayahDapil, $tingkat }] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil_map.csv
  fi
done

#'.[] as $wilayah | $wilayah.dapil[] | . as $dapil | $dapil.wilayah[] | . as $sub | [$dapil.id, $dapil.nama, $dapil.tingkat ] + [$sub.idWilayah, $sub.urutanWilayahDapil]|@tsv'