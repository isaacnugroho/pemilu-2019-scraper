#!/bin/bash

for p in result/dapil/dapil_kabupaten_wilayah_8688.json result/dapil/dapil_kabupaten_wilayah_6729.json result/dapil/dapil_kabupaten_wilayah_25072.json result/dapil/dapil_kabupaten_wilayah_25824.json result/dapil/dapil_kabupaten_wilayah_25833.json result/dapil/dapil_kabupaten_wilayah_25886.json result/dapil/dapil_kabupaten_wilayah_25924.json result/dapil/dapil_kabupaten_wilayah_25989.json result/dapil/dapil_kabupaten_wilayah_26065.json result/dapil/dapil_kabupaten_wilayah_32547.json result/dapil/dapil_kabupaten_wilayah_41501.json result/dapil/dapil_kabupaten_wilayah_51327.json result/dapil/dapil_kabupaten_wilayah_51550.json result/dapil/dapil_kabupaten_wilayah_53106.json result/dapil/dapil_kabupaten_wilayah_53650.json result/dapil/dapil_kabupaten_wilayah_53972.json result/dapil/dapil_kabupaten_wilayah_60255.json result/dapil/dapil_kabupaten_wilayah_60372.json result/dapil/dapil_kabupaten_wilayah_61929.json result/dapil/dapil_kabupaten_wilayah_76995.json result/dapil/dapil_kabupaten_wilayah_79826.json result/dapil/dapil_kabupaten_wilayah_80309.json result/dapil/dapil_kabupaten_wilayah_81007.json result/dapil/dapil_kabupaten_wilayah_82154.json result/dapil/dapil_kabupaten_wilayah_83194.json ; do
  jq -r '[.[]|{ id, idWilayah, maxAlokasiKursi, mean, minAlokasiKursi, stdDev, tingkat}] |
    (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil_kabupaten_alokasi2.csv

  jq -r '[.[] | .id as $refId |.dapil[] | { id, $refId, idWilayah, nama, noDapil, tingkat, totalAlokasiKursi, jumlahPenduduk }] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil_kabupaten2.csv

  jq -r '[.[] | .id as $refId | .dapil[] | .tingkat as $tingkat | .wilayah[] | { $refId, idDapil, idWilayah, namaWilayah, urutanWilayahDapil, $tingkat }] |
      (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $rows[] | @tsv' $p >> result/dapil_kabupaten_map2.csv
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
