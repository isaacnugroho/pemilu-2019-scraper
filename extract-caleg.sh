#!/bin/bash


i=0
for p in result/caleg/caleg_dpr_*.json; do
  v=$(echo $p | grep -oE '[0-9]+')
  if [[ i -eq 0 ]]; then
    jq -r --argjson dapilId "$v" '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/caleg_dpr.csv

    i=1
  else
    jq -r --argjson dapilId "$v" '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/caleg_dpr.csv

  fi
done

i=0
for p in result/caleg/caleg_provinsi_*.json; do
  v=$(echo $p | grep -oE '[0-9]+')
  if [[ i -eq 0 ]]; then
    jq -r --argjson dapilId "$v" '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/caleg_provinsi.csv

    i=1
  else
    jq -r --argjson dapilId "$v" '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/caleg_provinsi.csv

  fi
done

i=0
for p in result/caleg/caleg_kabupaten_*.json; do
  v=$(echo $p | grep -oE '[0-9]+')
  if [[ i -eq 0 ]]; then
    jq -r --argjson dapilId "$v" '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/caleg_kabupaten.csv

    i=1
  else
    jq -r --argjson dapilId "$v" '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/caleg_kabupaten.csv

  fi
done
