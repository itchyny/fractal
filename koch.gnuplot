reset

number = 6
sizex = 1200
sizey = 400
wid = 0.9
pad = (1 - wid) / 2 * 100;
padbottom = (1 - sizex * wid / 6 * sqrt(3) / sizey) / 2

set terminal jpeg size sizex,sizey
set output "koch.jpeg"
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

rotx(x,y,t) = cos(t) * x - sin(t) * y
roty(x,y,t) = sin(t) * x + cos(t) * y
koch(n, x, y, dx, dy) \
  = n >= number ?  \
    sprintf("set arrow from %f,%f to %f,%f as 1;", x, y, x+dx, y+dy) : \
    koch(n + 1 \
        , x \
        , y \
        , dx / 3 \
        , dy / 3). \
    koch(n + 1 \
        , x + dx / 3 \
        , y + dy / 3 \
        , rotx(dx / 3, dy / 3, pi / 3) \
        , roty(dx / 3, dy / 3, pi / 3)). \
    koch(n + 1 \
        , x + dx / 3 + rotx(dx / 3, dy / 3, pi / 3) \
        , y + dy / 3 + roty(dx / 3, dy / 3, pi / 3) \
        , rotx(dx / 3, dy / 3, - pi / 3) \
        , roty(dx / 3, dy / 3, - pi / 3)). \
    koch(n + 1 \
        , x + 2 * dx / 3 \
        , y + 2 * dy / 3 \
        , dx / 3 \
        , dy / 3);

eval(koch(0, 0.0, 0.0, 1.0, 0.0))

plot -100

