ZISX ;SF/GFT,AC - PROGRAM THAT XECUTES NODES IN ^%ZIS GLOBAL. ;1/3/90  15:08 ;
 ;;8.0;KERNEL;;Jul 10, 1995
X3 X ^%ZIS(2,+IOST(0),3) Q
X31 ;X ^%ZIS(2,+IOST(0),3.1) Q  ;Old code
X10 X ^%ZIS(2,IO("S"),10) Q
X11 X ^%ZIS(2,+IO("S"),11) K IO("S") Q
XPCX X ^%ZIS(1,+IOS,"PCX") Q
XPOX(X) ;Execute pre-open execute code.
 X ^%ZIS(1,+X,"POX") Q
%Y X %Y Q
XS X %ZIS("S") Q
XW X %ZIS("W") Q
