reset

number = 12
sizex = 600
sizey = 600
wid = 0.95
pad = (1 - wid) / 2 * 100;
padbottom = (1 - sizex * wid / sizey) / 2

set terminal jpeg size sizex,sizey
set output "dragon.jpeg"
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

hilbert(n, x, y, dx, dy) \
  = n >= number ?  \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x, y, x + dx, y + dy) : \
    hilbert(n + 1, x, y, (dx - dy) / 2, (dy + dx) / 2) . \
    hilbert(n + 1, x + dx, y + dy, - (dx + dy) / 2, (dx - dy) / 2);

eval(hilbert(0, 0.2, 0.4, 0.7, 0.0))

plot -100

