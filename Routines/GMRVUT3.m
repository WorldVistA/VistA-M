GMRVUT3 ;HIRMFO/YH,FT-VITAL MEASUREMENT SITE/QUALIFIER SELECTIO ;6/13/01  10:12
 ;;4.0;Vitals/Measurements;**1,11,13**;Apr 25, 1997
SETSITE ;SET THE V/M SITE FOR THE VARIAVLE GMRSITE
 ;GMRV WAS SET BY THE CALLING ROUTINE
 N G S G="" F  S G=$O(GMRW(G)) Q:G=""  I $E(G,1,$L(GMRSITE))=GMRSITE S GMRV=GMRV+1,GMRV(GMRV)=G
 Q:GMRV=0  I GMRV=1 S (GMRSITE(GMRVITY),GMRSITE)=GMRV(GMRV)_"^"_$G(GMRW(GMRV(GMRV))) Q
ASK W !!,GMRVIT(1)_":",! S G=0 F  S G=$O(GMRV(G)) Q:G'>0  W !,?5,G_".  "_GMRV(+G)
 W !!,"Select a number between 1 and "_GMRV_":  " S G(1)=0 R G(1):DTIME I '$T!(G(1)["^") S GMROUT=1 Q
 I $L(G(1))>3 G ASK
 I '$D(GMRV(+G(1))) G ASK
 S (GMRSITE,GMRSITE(GMRVITY))=GMRV(+G(1))_"^"_$G(GMRW(GMRV(+G(1))))
 Q
ROOMSEL ;
 W ! W:$G(GMRMSL($G(I(1))))'="" I(1),". ",?6,$G(GMRMSL(I(1))) W:$G(GMRMSL($G(I(2))))'="" ?16,I(2),".  ",$G(GMRMSL(I(2))) W:$G(GMRMSL($G(I(3))))'="" ?33,I(3),".  ",$G(GMRMSL(I(3)))
 W:$G(GMRMSL($G(I(4))))'="" ?49,I(4),".  ",$G(GMRMSL(I(4))) W:$G(GMRMSL($G(I(5))))'="" ?65,I(5),".  ",$G(GMRMSL(I(5)))
 S I(1)=(I(1)+1),I(2)=(I(2)+1),I(3)=(I(3)+1),I(4)=(I(4)+1),I(5)=(I(5)+1)
 Q
GIRTH ;INPUT TRANSFORM FOR CIRCUMFERENCE/GIRTH
 Q:"UNAVAILABLEPASSREFUSED"[$$UP^XLFSTR(X)  N UNIT S UNIT=$$UP^XLFSTR($P(X,+X,2)),X=+X I UNIT="" S UNIT="I" Q
 I UNIT="C" S X=$J(.3937*X,0,2),UNIT="I"
 I UNIT'="I" K X Q
 K:+X'=X!(X>200)!(X<0) X
 Q
CVP ;INPUT TRANSFORM FOR CVP
 Q:"UNAVAILABLEPASSREFUSED"[$$UP^XLFSTR(X)  N UNIT S UNIT=$$UP^XLFSTR($P(X,+X,2)) I $L(UNIT)>1!($L(UNIT)=1&($E(UNIT)'="G")) K X Q
 I UNIT'="" S X=X*1.36
 K:X<-13.6!(X>136) X
 Q
O2 ;SUPPLEMENTAL O2 FOR PULSE OXIMETRY
 N %,GMRV,GMRZ,GMRX,GMRY S (GMRSITE(GMRVITY),GMRINF(GMRVITY),GMRO2(GMRVITY))=""
ASKO2 S %=1 W !,"Is the patient on supplemental oxygen" D YN^DICN I %<0 S GMROUT=1 Q
 I %=0 G ASKO2
 Q:%=2
ASKINF W !!,"Enter the numeric value(s) for amount of supplemental oxygen provided",!,"(Separate values with a ',') : "
 S GMRV="" R GMRV:DTIME I '$T!(GMRV["^") S GMROUT=1 Q
 I $L(GMRV)>15 G ASKINF
 I GMRV["?" W !!,"Enter a number between 0.5-20 for liters/minute,   and/or ",!,?23,"21-100 for percent of oxygen concentration.",!,"If you wish to enter both rates, separate the values with a ','.",! G ASKINF
 Q:GMRV=""
 S GMRZ=0 D CHECK I GMRZ W !!,"ERROR ENTRY!",! G ASKINF
 I (GMRX["l/min"&(GMRY["l/min"))!(GMRX["%"&(GMRY["%")) W !!,"ERROR ENTRY!" G ASKINF
 I GMRY'="" D
 .N GMRVPO
 .I GMRX'["l/min",(GMRY["l/min") S:GMRX["%" GMRVPO=GMRY,GMRY=GMRX,GMRX=GMRVPO
 .Q
 S GMRO2(GMRVITY)=GMRX S:GMRY'="" GMRO2(GMRVITY)=GMRO2(GMRVITY)_$S(GMRO2(GMRVITY)="":"",1:" ")_GMRY S:GMRO2(GMRVITY)'="" GMRO2(GMRVITY)=GMRO2(GMRVITY)
 S GLVL=8 D LISTQ^GMRVQUAL
 Q:'$D(GCHART1)
ASKM S GMRV=$O(GCOUNT(1,GMRV))
 N GMRVSAVE
 S GMRVSAVE=GMRV
ASKM1 S GMRV=GMRVSAVE
 W !,"Oxygen is supplied by",!
 F I=1:1:GCOUNT(1,GMRV) W !,?5,I_" "_$P(GCHART1(I),"^")
 W !,"Enter a number: " S GMRV="" R GMRV:DTIME I '$T!(GMRV["^") S GMROUT=1 Q
 I $L(GMRV)>3 G ASKM1
 I $D(GCHART1(+GMRV)) S GMRSITE(GMRVITY)=GCHART1(+GMRV) Q
 I '$D(GCHART1(+GMRV)) G ASKM1
 I GMRV["?" G ASKM1
 Q
CHECK ;
 S GMRY=$P($G(GMRV),","),GMRX=$P($G(GMRV),",",2)
 I GMRX'="" D O2DATA(.GMRX,.GMRZ) Q:GMRZ
 I GMRY'="" D O2DATA(.GMRY,.GMRZ)
 Q
O2DATA(I,J) ;
 I '(I>0&(I<100.001)) S J=1 Q
 I I<20.01,I?0.3N0.1"."0.1N S I=I_" l/min" Q
 I I>20&(I<100.001),I?1.3N S I=I_"%" Q
 S J=1
 Q
