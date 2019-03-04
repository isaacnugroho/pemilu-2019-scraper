#!/bin/bash


i=0
for p in result/caleg/dapil_dpr_caleg_*.json; do
  v=$(echo $p | grep -oE '[0-9]+')
  if [[ i -eq 0 ]]; then
    jq -r --argjson dapilId $v '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/dapil_dpr_caleg.csv

    i=1
  else
    jq -r --argjson dapilId $v '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil_dpr_caleg.csv

  fi
done

i=0
for p in result/caleg/dapil_provinsi_caleg_*.json; do
  v=$(echo $p | grep -oE '[0-9]+')
  if [[ i -eq 0 ]]; then
    jq -r --argjson dapilId $v '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/dapil_provinsi_caleg.csv

    i=1
  else
    jq -r --argjson dapilId $v '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil_provinsi_caleg.csv

  fi
done

i=0
for p in result/caleg/dapil_kabupaten_caleg_*.json; do
  v=$(echo $p | grep -oE '[0-9]+')
  if [[ i -eq 0 ]]; then
    jq -r --argjson dapilId $v '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/dapil_kabupaten_caleg.csv

    i=1
  else
    jq -r --argjson dapilId $v '[.[] | { idDapil: $dapilId, namaPartai, id, noUrut, nama, stringJenisKelamin, originalFilename } ] |
        (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil_kabupaten_caleg.csv

  fi
done
