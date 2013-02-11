reset

number = 5
sizex = 600
sizey = 600
wid = 0.95
pad = (1 - wid) / 2 * 100;
padbottom = (1 - sizex * wid / sizey) / 2

set terminal jpeg size sizex,sizey
set output "hilbert.jpeg"
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

hilbert(n, x, y, dx, dy, dx2, dy2, dx3, dy3) \
  = n >= number ?  \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x + (dx - dy) / 4, y + (dy + dx) / 4, x + (3 * dx - dy) / 4, y + (3 * dy + dx) / 4) . \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x + (3 * dx - dy) / 4, y + (3 * dy + dx) / 4, x + (3 * dx - 3 * dy) / 4, y + (3 * dy + 3 * dx) / 4) . \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x + (dx - 3 * dy) / 4, y + (dy + 3 * dx) / 4, x + (3 * dx - 3 * dy) / 4, y + (3 * dy + 3 * dx) / 4) . \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x + (dx - 3 * dy) / 4, y + (dy + 3 * dx) / 4, x + (dx - 3 * dy) / 4 + dx2 / 2, y + (dy + 3 * dx) / 4 + dy2 / 2) . \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x + (dx - dy) / 4, y + (dy + dx) / 4,  x + (dx - dy) / 4 + dx3 / 2, y + (dy + dx) / 4 + dy3 / 2) : \
    hilbert(n + 1, x + dx / 2, y + dy / 2, - dy / 2, dx / 2, dx3 / 2, dy3 / 2, dx / 2, dy / 2). \
    hilbert(n + 1, x + dx / 2, y + dy / 2, dx / 2, dy / 2, - dy / 2, dx / 2, 0.0, 0.0). \
    hilbert(n + 1, x + dx / 2 - dy / 2, y + dy / 2 + dx / 2, dx / 2, dy / 2, -dx / 2, -dy / 2, 0.0, 0.0). \
    hilbert(n + 1, x - dy, y + dx, dy / 2, - dx / 2, 0.0, 0.0, dx2 / 2, dy2 / 2);

eval(hilbert(0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0))

plot -100

