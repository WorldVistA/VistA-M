LRHYLRX ;DALOI/HOAK - Playing inside the BOX ;8/28/2005
 ;;5.2;LAB SERVICE;**405**;Sep 27, 1994;Build 93
 ;
 ;
 W @IOF F V=2:2:20 S XX="TXT"_V D @XX D LRBOX(10,V,V,60,TXT)
 Q
 ;
 ;
LRBOX(X,Y,SIDE,LRHYHZ,TXT) ;This sub routine will draw a box on a VT100 terminal
 N LRHYI
 K DX,DY
 ;X and Y are the 1st coord.
 ;SIDE is the length vertical leg
 ;LRHYHZ is the length of the horozontal leg
 ;TXT is what you put in the box
 D GSET^%ZISS W IOG1
 S DY=Y,DX=X D XY
 W IOTLC
 F LRHYI=1:1:LRHYHZ W IOHL
 W IOTRC
 S DY=Y+1,DX=X D XY F LRHYI=1:1:SIDE W IOVL S DY=DY+1 D XY
 S DY=Y+1,DX=LRHYHZ+X+1 D XY F LRHYI=1:1:SIDE W IOVL S DY=DY+1 D XY
 S DY=Y+SIDE+1,DX=X D XY
 W IOBLC F LRHYI=2:1:LRHYHZ+1 W IOHL
 W IOBRC
 W IOG0 D GKILL^%ZISS
 Q
XY ;
 X IOXY
 Q
LRGLIN ;
 N LRHYHZ
 D GSET^%ZISS W IOG1
 F LRHYHZ=1:1:79 W IOHL
 W !,IOG0 D GKILL^%ZISS
 Q
