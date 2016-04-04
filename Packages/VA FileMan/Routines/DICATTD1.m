DICATTD1 ;SFISC/GFT- DATE,TIME ;2 FEB 2009
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**42,160**
 ;
EARLY ;
 S Y=">X" G Y
 ;
LATEST ;
 S Y="<X"
Y S Y=$F(DICATT5,Y) I Y S Y=$E(DICATT5,Y-9,Y-3) S:Y?.E1"DT" Y="DT" D:Y DD^%DT Q
 K Y Q
 ;
POST1 ;check DATE
 N Z,Y,%DT,I K DDSERROR
 S %DT="T"
 D  I $D(DDSERROR) D HLP^DDSUTL("'EARLIEST DATE' & 'LATEST DATE' ARE IN WRONG ORDER") S DDSBR="21^DICATT1^2.1" Q
 .S Y=$$G(21) I Y="DT" S X=$$G(22) D:X]""  Q
 ..I X'="DT" D ^%DT I Y<DT S DDSERROR=1 Q
 .Q:Y=""  S X=Y D ^%DT S X=$$G(22) Q:X=""  I X="DT" S:Y>DT DDSERROR=1 Q
 .S Z=Y D ^%DT I Y<Z S DDSERROR=1
 S DICATT5N="S %DT=""E"_$E("S",$$G(25)=1)_$E("T",$$G(24)=1)_$E("X",$$G(23)=0)_$E("R",$$G(26)=1)_""" D ^%DT S X=Y K:"
FROMTO K DICATTMN F I=21,22 S Z=$$G(I) Q:Z=""  D
 .I Z="DT" S Y=Z,Z="CURRENT DATE"
 .E  S X=Z D ^%DT S X=Y D DD^%DT S Z=Y,Y=X
 .S DICATTMN(I)=Z,DICATT5N(I)=Y ;Z is readable, Y internal
 I $D(DICATTMN(22)) S DICATTMN="Type a date between "_DICATTMN(21)_" and "_DICATTMN(22)_".",DICATT5N=DICATT5N_DICATT5N(22)_"<X!("_DICATT5N(21)_">X) X"
 E  I $D(DICATTMN(21)) S DICATTMN="Type a date not earlier than "_DICATTMN(21)_".",DICATT5N=DICATT5N_DICATT5N(21)_">X X"
 E  S DICATT5N=DICATT5N_"X<1 X",DICATTMN="(No range limit on date)"
 S DICATTLN=$$G(24)=1*5+7
 S DICATT2N="D",DICATT3N=""
 S X=DICATT5N K DICATT5N S DICATT5N=X ;get rid of those damn subscripts
CHNG I DICATT5N=DICATT5 K DICATTMN ;No DICATTMN means no change
 D:$D(DICATTMN) PUT^DDSVALF(98,"DICATT",1,DICATTMN)
 Q
 ;
G(I) N X Q $$GET^DDSVALF(I,"DICATT1",2.1,"I","")
