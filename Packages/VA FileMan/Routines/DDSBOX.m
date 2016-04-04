DDSBOX ;SFISC/MKO-DRAW A BOX ;2015-01-02  6:19 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
EN(DDSUL,DDSLR) ;move entry point from topoof routine.
 ;
 D BOUNDS Q:'Y
 ;
 S DDS3L=""
 S $P(DDS3L,$P(DDGLGRA,DDGLDEL,3),$P(DDSLR,",",2)-$P(DDSUL,",",2))=""
 S DDS3M=$P(DDGLGRA,DDGLDEL,4)_$J("",$P(DDSLR,",",2)-$P(DDSUL,",",2)-1)_$P(DDGLGRA,DDGLDEL,4)
 ;
 S DY=$P(DDSUL,",")-1,DX=$P(DDSUL,",",2)-1 X IOXY
 W $P(DDGLGRA,DDGLDEL)_$P(DDGLGRA,DDGLDEL,5)_DDS3L_$P(DDGLGRA,DDGLDEL,6)
 ;
 F DY=$P(DDSUL,","):1:$P(DDSLR,",")-2 D
 . S DX=$P(DDSUL,",",2)-1 X IOXY
 . W DDS3M
 ;
 S DY=$P(DDSLR,",")-1,DX=$P(DDSUL,",",2)-1 X IOXY
 W $P(DDGLGRA,DDGLDEL,7)_DDS3L_$P(DDGLGRA,DDGLDEL,8)_$P(DDGLGRA,DDGLDEL,2)
 ;
 K DDS3L,DDS3M
 Q
 ;
CLEAR(DDSUL,DDSLR) ;Clear area within upper left and lower right coords
 N S
 D BOUNDS Q:'Y
 ;
 S S=$J("",$P(DDSLR,",",2)-$P(DDSUL,",",2)+1)
 S DX=$P(DDSUL,",",2)-1
 F DY=$P(DDSUL,",")-1:1:$P(DDSLR,",")-1 X IOXY W S
 Q
 ;
BOUNDS ;Make sure area is within acceptable boundaries
 N DDSV,DDSP
 S Y=1
 I $G(DDSUL)=""!($G(DDSLR))="" S Y=0 Q
 ;
 F DDSV="DDSUL","DDSLR" D
 . S:$P(@DDSV,",")>DDSHBX $P(@DDSV,",")=DDSHBX
 . S:$P(@DDSV,",",2)>(IOM-1) $P(@DDSV,",",2)=IOM-1
 . F DDSP=1,2 S:$P(@DDSV,",",DDSP)<1 $P(@DDSV,",",DDSP)=1
 ;
 I $P(DDSLR,",")-$P(DDSUL,",")<2 S Y=0 Q
 I $P(DDSLR,",",2)-$P(DDSUL,",",2)<2 S Y=0 Q
 ;
 Q
