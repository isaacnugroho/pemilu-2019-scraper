#!/bin/bash

i=0
for p in result/wilayah/*.json; do
  if [[ i -eq 0 ]]; then
    jq -r '[.[]|{ id, idParent, namaWilayah, tingkatWilayah, idPro, idKab, idKec, namaPro, namaKab, namaKec, namaKel, kodeWilayah }] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/wilayah.csv && i=1
  else
    jq -r '[.[]|{ id, idParent, namaWilayah, tingkatWilayah, idPro, idKab, idKec, namaPro, namaKab, namaKec, namaKel, kodeWilayah }] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/wilayah.csv
  fi
done

# jq -r '[.[] | .id as $refId | .dapil[] | .id as $dapilId | .wilayah[] | { $dapilId, $refId, idWilayah, namaWilayah, urutanWilayahDapil }] |''

# jq -r '.[] | { idParent: .id, dapil: .dapil | map ( with_entries(select(.key != "wilayah")) ) } { idParent, idDapil: .dapil[].id, idWilayah: .dapil[].idWilayah, jumlahPenduduk: .dapil[].jumlahPenduduk,
# namaDapil: .dapil[].nama, noDapil: .dapil[].noDapil, tingkatDapil: .dapil[].tingkat,
# totalAlokasiKursi: .dapil[].totalAlokasiKursi } ' result/dapil/dapil_dpr_wilayah_1.json
#
#
#     jq -r '[.[] | .id as $refId |.dapil[] | { id, $refId, idWilayah, nama, noDapil, tingkat, totalAlokasiKursi, jumlahPenduduk }] |
#       (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' result/dapil/dapil_dpr_wilayah_1.json
#
#
# jq -r '[.[] | { idParent: .id, dapil: .dapil } |
#     { idParent, idDapil: .dapil[].id, idWilayah: .dapil[].idWilayah, jumlahPenduduk: .dapil[].jumlahPenduduk,
#     namaDapil: .dapil[].nama, noDapil: .dapil[].noDapil, tingkatDapil: .dapil[].tingkat, totalAlokasiKursi: .dapil[].totalAlokasiKursi } |
#     (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv' $p > result/dapil_dpr.csv
