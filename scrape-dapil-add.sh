#!/bin/sh

getJson() {
  if curl -k "$1" -o /tmp/temp_$$; then
    if [[ -f /tmp/temp_$$ && $(jq -r '.' /tmp/temp_$$) ]]; then
      cat /tmp/temp_$$ >> $2
    else
      echo $1 $2 >> scrape-dapil-add-error.txt
    fi
  fi
}

for p in 671 1207 1492 2452 3205 4086 4989 5138 5286 5463 6728 6729 6789 6888 7132 7240 7438 7697 7960 8094 8408 8688 9114 9497 9727 9835 10020 10227 10646 11022 11083 11247 11374 11635 11743 11916 11978 12000 12038 12081 12122 12208 12606 12920 12921 13010 13099 13163 13253 13317 13416 13509 13554 13608 13634 13681 13712 13828 13844 13886 13905 13933 14010 14086 14087 14166 14414 14630 14678 14741 14955 15087 15254 15412 15553 15775 15846 15885 15886 15961 16183 16420 16576 16699 16862 16946 17051 17215 17333 17404 17405 17570 17895 18244 18643 18942 19172 19492 19808 20087 20345 20512 20636 20677 20758 20802 20803 20923 21093 21265 21492 21702 21885 22052 22135 22252 22328 22329 22439 22522 22605 22875 23189 23460 23737 23903 24202 24484 24709 24822 24850 24993 24994 25072 25120 25181 25245 25316 25363 25405 25406 25429 25471 25533 25597 25683 25746 25823 25824 25833 25886 25924 25989 26065 26141 26142 26611 27026 27407 27714 28182 28573 28960 29369 29834 30197 30503 30851 31135 31345 31685 31896 32077 32152 32193 32375 32403 32472 32547 32566 32646 32676 32677 32986 33345 33603 33902 34389 34900 35181 35575 35862 36290 36470 36790 36985 37214 37514 37826 38136 38564 38706 38917 39181 39436 39746 40053 40317 40622 40859 41165 41480 41501 41558 41585 41779 41831 41863 41864 41965 42058 42221 42325 42385 42386 42570 42897 43069 43360 43630 43993 44417 44643 44923 45165 45407 45561 45916 46306 46678 47001 47329 47634 47856 48110 48347 48805 49154 49656 50031 50331 50532 50735 51095 51145 51170 51233 51268 51306 51327 51358 51550 51578 51579 51913 52287 52593 52936 53054 53106 53179 53241 53242 53299 53439 53508 53586 53650 53727 53814 53972 54020 54021 54123 54260 54400 54590 54666 54853 54925 54982 55026 55065 55066 55347 55620 55819 56051 56244 56489 56671 56904 57008 57167 57346 57406 57560 57649 57778 57886 57935 58040 58098 58219 58285 58286 58490 58567 58749 59018 59320 59557 59699 59869 59953 60134 60183 60223 60255 60371 60372 60468 60653 60867 60967 61077 61251 61362 61400 61492 61614 61711 61846 61929 61965 61966 62112 62333 62643 62861 63007 63167 63348 63578 63722 63866 64027 64085 64111 64112 64248 64496 64617 64709 64949 65069 65315 65469 65528 65567 65631 65656 65675 65702 65703 65760 65822 65974 66188 66371 66544 66718 66853 66936 67035 67130 67227 67305 67355 67393 67394 67558 67866 68041 68206 68309 68428 68681 68887 69089 69220 69268 69269 69442 69531 69668 69744 69869 69962 70149 70239 70639 70757 70873 70935 71014 71209 71327 71437 71579 71828 72007 72190 72309 72467 72493 72551 72552 72786 73150 73420 73650 74018 74179 74288 74437 74525 74590 74665 74716 74717 74941 75031 75183 75301 75365 75425 75426 75502 75670 75863 76047 76096 76097 76223 76284 76470 76568 76651 76708 76771 76868 76995 77051 77085 77086 77155 77311 77364 77578 77858 77956 78040 78122 78203 78204 78289 78324 78862 78927 79019 79163 79310 79354 79421 79466 79531 79564 79629 79663 79752 79826 80015 80144 80309 80402 80526 80724 80851 81007 81104 81192 81261 81357 81877 81878 81992 82022 82154 82605 82724 82850 82965 83107 83194 83289 927964 928068 928069 928070 928071 928072 928073 928074 928075 928076 928077 928078 928079 928080 928081 928082 928083 928084 ; do
  if [[ ! -f result/dapil/dapil_wilayah_$p.json ]]; then
    getJson https://infopemilu.kpu.go.id/pileg2019/api/dapil/$p/2?_=$(date +%s) result/dapil/dapil_wilayah_$p.json
  fi
done