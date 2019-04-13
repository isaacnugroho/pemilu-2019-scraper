#!/bin/bash


i=0
for p in result/caleg/caleg_dpr_perubahan_*.json; do
  v=$(echo $p |  grep -oE '[0-9]+' | awk -e 'NR == 1 { print }')
  if [[ i -eq 0 ]]; then
    jq -r --argjson dapilId "$v" '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' $p > result/caleg_dpr_perubahan.csv && i=1
  else
    jq -r --argjson dapilId "$v" '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @csv' $p >> result/caleg_dpr_perubahan.csv

  fi
done

i=0
for p in result/caleg/caleg_provinsi_perubahan_*.json; do
  v=$(echo $p |  grep -oE '[0-9]+' | awk -e 'NR == 1 { print }')
  if [[ i -eq 0 ]]; then
  echo $v
    jq -r --argjson dapilId "$v" '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' $p > result/caleg_provinsi_perubahan.csv && i=1
  else
    jq -r --argjson dapilId "$v" '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @csv' $p >> result/caleg_provinsi_perubahan.csv

  fi
done

i=0
for p in result/caleg/caleg_kabupaten_perubahan_*.json; do
  v=$(echo $p |  grep -oE '[0-9]+' | awk -e 'NR == 1 { print }')
  echo $v
  if [[ i -eq 0 ]]; then
    jq -r --argjson dapilId "$v" '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' $p > result/caleg_kabupaten_perubahan.csv && i=1
  else
    jq -r --argjson dapilId "$v" '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @csv' $p >> result/caleg_kabupaten_perubahan.csv

  fi
done
