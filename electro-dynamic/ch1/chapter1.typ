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

= Vector Analysis


=== Gradient

gradient dari $T$

$ nabla T = (d T)/(d x) hat(x) + (d T)/(d y) hat(y) + (d T)/(d z) hat(z) $

=== Del Operator 

*del operator* adalah operator yang digunakan pada gradient

$ nabla = d/(d x) hat(x) + d/(d y) hat(y) + d/(d z) hat(z) $

=== Divergence 

secara intepretasi geometris, Divergence digunakan untuk menghitung seberapa besar penyebaran vetor $V$ (spread/diverges) dari titik pusat.

$ nabla times VV = 
                    mat(
                      hat(x),   hat(y),   hat(z);
                      d/(d x),  d/(d y),  d/(d z);
                      V_x,      V_y,      V_z
                    )
$

=== Curl 
secara intepretasi geometris curl digunakan untuk mengukur besar vector V berputar mengelingkar (swirl) disekitar poin tertentu.
untuk mendapatkan persamaan umum (inline) gunakan determinant

$ nabla times V =
  mat(
    hat(x), hat(y), hat(z);
    frac(d, d x), frac(d, d y), frac(d, d z);
    V_x, V_y, V_z,
  )
$

=== Laplacian 

Turunan ke-2 dari gradient disebut laplacian

$ nabla dot (nabla T) =
  ( frac(d, d x) hat(x) + frac(d, d y) hat(y) + frac(d, d z) hat(z) )
  ( frac(d, d x) hat(x) + frac(d, d y) hat(y) + frac(d, d z) hat(z) ) T \

= frac(d^2 T, d x^2) + frac(d^2 T, d y^2) + frac(d^2 T, d z^2) $

atau

$ nabla dot (nabla T) = nabla^2 T $

disebut laplacian

curl dari gradient selalu 0

$ nabla times (nabla T) = 0 $

divergence dari curl selalu 0

$ nabla dot (nabla times T) = 0 $


=== Irational Vector 

Untuk menentukan apakah vektor $ hat(F) $ irrotational, dapat digunakan curl.

$ "Curl" hat(F) = nabla times hat(F) $

Lalu apakah curl F sama dengan nol (0), jika ya, maka F irrotational.

$ hat(F) = 0 ? "Irrotational" : "Rational" $
