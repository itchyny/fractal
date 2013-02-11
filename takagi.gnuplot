reset

number = 9
sizex = 400
sizey = 400
wid = 0.95
pad = (1 - wid) / 2 * 100;
padbottom = (1 - sizex * wid / 2 * sqrt(3) / sizey) / 2

set terminal jpeg size sizex,sizey
set output "takagi.jpeg"
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

takagi(n, x, y, dx, dy) \
  = n >= number ?  \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x, y, x + dx, y + dy) : \
    takagi(n + 1, x, y, dx / 2, dy / 2 + dx / 2). \
    takagi(n + 1, x + dx / 2, y + dy / 2 + dx / 2, dx / 2, dy / 2 - dx / 2);

eval(takagi(0, 0.0, 0.0, 1.0, 0.0))

plot -100


