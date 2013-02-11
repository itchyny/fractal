reset

number = 7
sizex = 600
sizey = 600
wid = 0.90
pad = (1 - wid) / 2 * 100;
padbottom = (1 - sizex * wid / 2 * sqrt(3) / sizey) / 2

set terminal jpeg size sizex,sizey
set output "sierpinski.jpeg"
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

sierpinski(n, x, y, dx) \
  = n >= number ?  \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x, y, x + dx, y) . \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x, y, x + dx / 2, y + dx / 2 * sqrt(3)) . \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x + dx, y, x + dx / 2, y + dx / 2 * sqrt(3)) : \
    sierpinski(n + 1, x, y, dx / 2). \
    sierpinski(n + 1, x + dx / 2, y, dx / 2). \
    sierpinski(n + 1, x + dx / 4, y + dx / 4 * sqrt(3), dx / 2);

eval(sierpinski(0, 0.0, 0.0, 1.0))

plot -100

