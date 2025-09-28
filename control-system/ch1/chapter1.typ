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

= Introduction 

perkembangan controls system diawali oleh minorsky, hazen, nyquist


- 1922 - Minorsky: mengembangkan auto ship controllers
- 1932 - Nyquist: mengembangkan close loop stability dari open loop Response
- 1934 - Hazen: mengembangkan servo mechanism


pada tahun 1940an penggunaan frekuensi response (yang di prakarsai oleh Bode) membuat performa control system
dapat memenuhi kebutuhan industri.

pada tahun 1940an zieglers dan nichols menyarankan sebuah metode tunning PID yg biasa disebut dengan tunning 
nichols.

pada akhir 1940an hingga 1950an, metode root locus telah dikembangkan oleh Evan.

*Modern Plant*, pada tahun 1960an control sistem semakin complex, menyebabkan control theory 
yang hanya SISO(single input single output) tidak bisa memenuhi kebutuhan industri yang memerlukan 
MIMO(multiple input multiple output), seiring berkembangnya komputer pada masa itu dikembangkan sebuah modern control 
theory menggunakan metode *state variable* untuk memenuhi kebutuhan MIMO.

dari tahun 1980an hingga 1990an robust control system menjadi topik utama dalam pemngembangan modern control system. 
namun karena matematika control system untuk *robust control system* berat, biasanya robust control 
system diberikan pada level graduate.

desain control system berdasarkan rentang error dari plant, lalu membuat controller adalah prinsip 
*robust controls system*


== Mathematical Model 

umumnya model matematis dari sebuah sistem dapat direpresentasika dengan persamaan diferensial. 
untuk menentukan karakteristik dari sebuah sistem dapat digunakan transfer function dan impulse respone.

transfer function adalah fungsi yang mendeskripsikan hubungan antara input-output dari sebuah sistem.
transfer function dari *LTI* didefinisikan sebagai rasio dari laplace transform output terhadap laplace
transform input, dengan asumsi sistem memiliki *intial zero condition*.

umpamakan sistem LTI sebagai berikut 

$ a_0 Y^n + a_1 Y^(n-1) + … + a_(n-1) Y^* + a_n Y \
= b_0 X^m + b_1 X^(m-1) + … + b_(n-1) X^* + b_n X ; (n >= m) $

Transfer function dari fungsi diatas adalah
$ G(S) = LL(O_"output") / LL(I_"input") \
= frac(Y(S), X(S)) \
= frac(b_0 S^n + b_1 S^(m-1) + … + b_(m-1) S + b_m,
       a_0 S^n + a_1 S^(n-1) + … + a_(n-1) S + a_n) $

orde sistem dapat ditentukan dengan melihat pangkat tertinggi dari $S$ jika $S$ memiliki pangkat tertinggi $n$
maka sistem tersebut ber-order $n$.

== Convolution Integral

$ GG(SS) = YY(SS) / XX(SS) $ 

yang diasumsikan memiliki zero initial condition, $Y(S)$ dapat ditulis.

$ YY(SS) = GG(SS) / XX(SS) $ 

multiplication pada complex domain atau frekuensi domain sama dengan konvolusi pada domain waktu (duality)
sehingga 

$ y(t) = integral_0 ^t x(tau) g(t - tau) d tau $


== Impulse Response

sebuah sistem LTI dengan zero intial condition, diberi input impulse. karena laplace transform dari impulse
adalah satu(*unity*), maka laplace transform dari output tersebut dapat ditulis sebagai berikut.

$  YY(SS) = GG(SS) XX(SS) = GG(SS) 1 YY(SS) = GG(SS) $

sehingga dengan menggunakan impulse dan mengukur output sebuah sistem dapat ditentukan karakteristik dari 
sistem tersebut (transfer functionnya).

== Block Diagram

untuk merepresentasikan sistem dalam bentuk grafik, dapat digunakan block diagram.

#figWithImg("../img/openloopDiagram.JPG", caption: "open loop control system")

open loop control system $G(S) = C(S)/R(S)$

== Close Loop Control System

#figWithImg("../img/closeloopDiagram.JPG", caption: "close loop control system")

rasio feedback terhadap error adalah open loop transfer function 
$ "openLoopTF" = B(S) / R(S) = G(S) H(S) $

rasio output terhadap error dadalah feedforward transfer function 

$ "feedForwareTF" = C(S) / E(S) = G(S) $

rasio output terhadap input disebut close loop transfer function.

$ C(S)/R(S) = G(S) / (1 + G(S)H(S)) $

sehingga output dari close loop sistem hanya bergantung pada input dan close loop transfer function saja.

== Automatic Control System

sebuah automatic control controller membandingkan output dengan nilai input, lalu menentukan error/deviasi 
dan menghasilkan sinyal control untuk mengurangi/memperkecil error hingga 0.
