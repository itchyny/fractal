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
    sprintf("set object rect from %f,%f to %f,%f fc rgb '#000000' fs solid;", x, y, x + d, y + d) : \
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


