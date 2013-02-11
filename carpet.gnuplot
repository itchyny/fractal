reset

number = 5
sizex = 800
sizey = 800
wid = 0.95
pad = (1 - wid) / 2 * 100;
padbottom = (1 - sizex * wid / sizey) / 2

set terminal jpeg size sizex,sizey
set output "carpet.jpeg"
set lmargin pad
set rmargin pad
set tmargin 0
set bmargin 0
set origin 0,padbottom
set border 0
set notitle
set nokey
unset xtics
unset ytics
set xrange [0:1]
set yrange [0:1.0/sizex*sizey/wid]
set style arrow 1 nohead linewidth 1

carpet(n, x, y, d) \
  = n >= number ?  \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x, y, x + d, y) . \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x + d, y, x + d, y + d) . \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x + d, y + d, x, y + d) . \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x, y + d, x, y) : \
    carpet(n + 1, x, y, d / 3) . \
    carpet(n + 1, x + d / 3, y, d / 3) . \
    carpet(n + 1, x + 2 * d / 3, y, d / 3) . \
    carpet(n + 1, x, y + d / 3, d / 3) . \
    carpet(n + 1, x + 2 * d / 3, y + d / 3, d / 3) . \
    carpet(n + 1, x, y + 2 * d / 3, d / 3) . \
    carpet(n + 1, x + d / 3, y + 2 * d / 3, d / 3) . \
    carpet(n + 1, x + 2 * d / 3, y + 2 * d / 3, d / 3);

eval(carpet(0, 0.0, 0.0, 1.0))

plot -100


