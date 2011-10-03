YTAUDIT ;SLC/TGA-AUDIT PSYCH TESTS ; 7/10/89  11:20 ;
 ;;5.01;MENTAL HEALTH;**37**;Dec 30, 1994
 ;
 ; Called from the top by MENU option YSTSTAUD
 ;
 W @IOF,?30,"Test/Interview Audit" W !!!
1 ;
 S %DT="AEQ",%DT("A")="BEGINNING DATE: " D ^%DT G:Y<1 END S YSB=Y
 S %DT("A")="ENDING DATE: " D ^%DT G:Y<1 END I Y<YSB W " ?",$C(7),!,"Ending date may not be after begining date!" G 1
 S YSE=Y,YSFLB=YSB-1,%ZIS="Q" D ^%ZIS G:POP END I $D(IO("Q")) S ZTRTN="ENP^YTAUDIT",(ZTSAVE("YSB"),ZTSAVE("YSE"),ZTSAVE("YSFLB"),ZTSAVE("YSFLB"))="",ZTDESC="YS AUDIT RPT" D ^%ZTLOAD G END
ENP ;
 U IO S YSLFT=0,P0=$S(IOST?1"P".E:1,1:0),P1=5 D H S P=0 F  S P=$O(^YTD(601.2,P)) Q:'P!(YSLFT)  S T=0 F  S T=$O(^YTD(601.2,P,1,T)) Q:'T!(YSLFT)  Q:'$D(^YTT(601,T))  F D=YSFLB:0 S D=$O(^YTD(601.2,P,1,T,1,D)) Q:'D!(D>YSE)  D P Q:YSLFT
 W ! D KILL^%ZTLOAD,^%ZISC G END
P ;
 S D(1)=$G(^YTD(601.2,P,1,T,1,D,0)),P(1)=$S($D(^DPT(P,0)):$P(^(0),U),1:P),T(1)=$S($D(^YTT(601,T,0)):$P(^(0),U),1:T),D(3)=$P(D(1),U,3),D(4)=$P(D(1),U,4)
 S D(3)=$S($D(^VA(200,+D(3),0)):$P(^(0),U),1:D(3)),D(4)=$S($D(^VA(200,+D(4),0)):$P(^(0),U),1:D(4))
 D:$Y+P1>IOSL CK Q:YSLFT  W P(1),?35,T(1),?47,$$FMTE^XLFDT(D,"5ZD"),!?10,D(4),?49,D(3),!! Q
END ;
 K %DT,%ZIS,D,I0,IO("Q"),YSLFT,P,P0,P1,T,X,Y,YSB,YSE,YSFLB,ZTSK Q
H ;
 W @IOF,"Test Audit for Period ",?22 S Y=YSB D DT W ?34," through ",?42 S Y=YSE D DT W !,"Patient",?35,"Instrument",?47,"Date",!?10,"Initiated by",?49,"Requested by",!! Q
CK ;
 D:'P0 WAIT^YSUTL Q:YSLFT  D:P0 H Q
 Q
DT ;
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
