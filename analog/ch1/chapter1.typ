#set heading(numbering: "1.1.")
#set figure(numbering: "Fig 1.1.")
#set math.equation(numbering: "Eq1.1.")
#set par(justify: true)

#let figWithImg(path, caption: "" ) = {
  figure(
    image(path), 
    caption: caption
  )
}

= Komparator

komparator adalah device yang membandingkan(compare) dua buah tegangan atau 
arus, output dari komparator akan mengindikasikan input mana yang lebih besar. 

== Komparator Sederhana / Voltage level Detector


#figure(
  image("../img/nonHComparator.png")
)

komparator dapat dirangkai menggunakan opamp, input negatif dan positif
opamp diberi 2 buah tengangan yang berbeda. ketika input tegangan positif
lebih besar dari input tengangan negatif, output komparator akan akan sama
dengan VCC atau tegangan supply positif dari opamp, dan jika input tegangan
positif lebih kecil dari input tegangan negatif, maka output komparator akan
sama dengan -VCC atau supply negatif dari opamp.

secara sederhana kompartor dengan konfigurasi seperti gambar diatas dapat
dituliskan sebagai berikut @eq1 (ingat terniary operator)

$ V_"out" = V_"in" > V_"Ref" ? +V_"cc" : -V_"cc" $ <eq1>

== Zero Crossing Comparator 

comparator jenis ini memiliki titik tengah di tegangan referensi (gnd). dengan
nilai histerisis dapat dihitung dengan persamaan dibawah ini(histerisis adalah
standard untuk menunjukan performa dari komparator).

#figure(
  image("../img/zeroCrossingComparator.JPG"),
  caption: "zero crossing comparator"
)

$ V_h = V_"ut" - V_"lt" \
  V_"ut" = "R2" / ("R1" + "R2") * +V_"sat"\
  V_"ut" = "R1" / ("R1" + "R2") * -V_"sat"
$

dimana:

$V_h$ = tegangan histerisi

$V_"lt"$ = Low Threshold Voltage

$V_"ut"$ = Upper Threshold Voltage

penalaran: jika komparator dengan tegangan supply + − 5V , dan R1 =
R2 = 1K. ketika E1 < 2.5V output VOUT = +VSAT , namun jika E1 > 2.5V
output akan switch menjadi VOUT = −VSAT , VOUT akan kembali ke +VSAT
ketika E1 < −2.5V . +2.5V dan −2.5V disebut VUT dan VLT (hal ini terjadi
jika komparatornya inverting).



#figure(
  image("../img/zeroCrossingGraph.JPG")
)

== Voltage Level Detector With Histerisis

terkadang tegangan tengah yang diinginkan saat melakukan komparasi tidaklah
0V, melainkan nilai tegangan melebihi 0V. rangkaian komparator yang telah
diberikan pada gambar diatas memiliki tegangan tengah di 0V, namun dengan memberikan offset tegangan baik pada positif feedback maupun pada kaki
negatif, dapat memberikan offset pada tegangan tengah sesuai dengan keinginan.

terdapat 2 buah jenis voltage level detector with hysterisis, yaitu
non-inverting dan inverting voltage level detector with hysiterisis.

=== Non Inverting Voltage Detector With Histerisis

#figure(
  image("../img/nonInvertingVoltageLevelDetector.JPG"),
  caption: "non inverting voltage level detector with ysterisis"
)

rasio nR, R menentukan nilai VUT , VLT , VCT R, untuk menurunkan rumus
gunakan nodal analysis. rumus akhir adalah sebagai berikut


$ V_"ut" = V_"Ref"(1 + 1/n) - (-V_"sat"/n) $
$ V_"lt" = V_"Ref"(1 + 1/n) - (+V_"sat"/n) $
$ V_"ctr" = (V_"ut" + V_"lt") / 2 = V_"ref" (1 + 1/n) $

untuk menuruntkan rumus VUT , VLT dapat digunakan nodal analysis dan
mensamadengankan 0, karena untuk menganalisis opamp ideal, dianggap tidak
ada arus yang masuk ke kaki positif maupun negatif.

$E_1 = V"ut" = V_"lt"$ dan $V_o = +V"sat "= −V_"sat"$ tegantung dengan keadaan komparator pada saat itu.

#figure(
  image("../img/invertingHisterisis.JPG")
)

=== Inverting Voltage Detector With Histerisis

untuk menurunkan rumus inverting voltage level detector with hysterisis
hampir sama dengan non-inverting, yaitu menggunakan analisis nodal. dalam
hal rangkaian perbedaan inverting dengan non-inverting yaitu, inverting memasukan tegangan input(E1) ke kaki negatif, dan tegangan VRef ke kaki feedback.


#figure(
  image("../img/invertingVoltageLevelDetector.JPG"),
  caption: "inverting voltage level detector with 741"
)

$ (V_"ref" - E_1) / R = (E_1 - V_o)/ (n R)\
  E_1/n + E_1 = V_o/n + V_"ref"\
  E_1 = ( (V_o/n) + V_"ref" ) / (1+1/n)\
  E_1 = (V_o + n V_"ref") / (n+1)
  E_1 = V_"ref" n/(n+1) + V_o/(n+1)
$

berikut adalah contoh histerisis inverting voltage level detector with hysterisis, dan rumus finalnya. E1 = VUT = VLT dan V o = +Vsat = −Vsat tegantung
dengan keadaan komparator pada saat itu

#figWithImg("../img/invertingHisterisis.JPG")

