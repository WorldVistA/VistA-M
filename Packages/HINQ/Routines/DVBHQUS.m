DVBHQUS ;ISC-ALBANY/PKE-CHECK STATUS in suspense ; 04 OCT 85  4:07 pm
 ;;4.0;HINQ;**31**;03/25/92 
LK S X=0,DIC="^DPT(",DIC(0)="AEMQ" D ^DIC Q:Y'>0  S X=+Y
UP I X S DIC="^DVB(395.5,",DIC(0)="NQ" D ^DIC S DFN=+Y I Y'>0 W !,?22,"Patient not in Suspense file" G LK
 Q
FIND D LK I Y>0 D UP I Y>0 S Y0=$Y,Y1=0 S IOP="HOME" D ^%ZIS K IOP D CODE W !! D WRTMESS,VER K Y0,R,R1 G FIND
 ;
 K DVBIXMZ
EX K DIC,I,DVBLN,DVBUSER,DVBI,DFN,R,R1,Y,Y0,Y1,X,Y,Z,C,G,DR,DIC,DA,D0 QUIT
 Q
FILM ; 
 S DFN=D0 S Y0=$Y D CODE W !! D WRTMESS Q
 Q
CODE Q:'$D(DFN)  F G=3,4,5 I $D(^DD(395.5,G,0)) S R(G)=$P(^(0),U)
 S R(8)="Last Updated",Y1="" I $D(^DVB(395.7,DFN,0)) S Y1=$P(^(0),U,3)
 Q:'$D(^DVB(395.5,DFN,0))  S Y=$P(^(0),U,3),Z=$P(^(0),U,4),Y0=$P(^(0),U,6),DVBI=$P(^(0),U,5),DVBI=$S(DVBI="Y":"YES",1:"NO"),Z=$S(Z="P":"Pending",Z="N":"NEWMAIL",Z="E":"Error",Z="V":"IDCU Error",Z="A":"Abbreviated",1:"")
 D TM W @IOF S Y0=$Y W !!,R(3),": ",Y,?46,R(4),?61,": ",Z
 S Y=Y1 D TM S Y1=Y W !,R(5),?21,": ",DVBI,?46,R(8),?61,": ",Y1
 K R1 F DVBUSER=0:0 S DVBUSER=$O(^DVB(395.5,DFN,1,DVBUSER)) Q:'DVBUSER  S:$D(^DVB(395.5,DFN,1,DVBUSER,0)) R1(DVBUSER)=$P(^(0),U,2)
USER F DVBUSER=0:0 S DVBUSER=$O(R1(DVBUSER)) Q:'DVBUSER  I $D(^VA(200,DVBUSER,0)) W !,"REQUESTED BY",?21,": ",$E($P(^(0),U,1),1,23),?46 S Y=R1(DVBUSER) D TM W "TIME OF REQUEST",?61,": ",Y
 Q
TM S Y=$E(Y,1,12),Y=$$FMTE^XLFDT(Y,"5F"),Y=$TR(Y," ","0") Q
 ;
WRTMESS Q:'$D(^DVB(395.5,$S($D(DFN):DFN,1:0),0))  S DVBIXMZ=$P(^(0),U,7) Q:'DVBIXMZ
 S:'$D(Y0) Y0=$Y
 Q:'$D(^XMB(3.9,DVBIXMZ,0))  S Y=$P(^(0),U,3) D TM W $P(^(0),U)," ",Y,!
 F DVBLN=1:1 Q:'$D(^XMB(3.9,DVBIXMZ,2,DVBLN,0))  W $E(^(0),1,80),! W:$L(^(0))>80 $E(^(0),81,150),! W:$L(^(0))>150 $E(^(0),151,226),! D:($Y-Y0)>(IOSL-3-Y1) SCROL Q:X="^"  D:$Y<Y0 ABS
 K DVBSCROL Q
ABS S Y0=255-Y0 Q:$Y+Y0<(IOSL-3-Y1)
SCROL I $E(IOST,1)["C" W !,"Press return to continue "_$C(7) R X:DTIME Q:'$T!(X="^")  S Y0=$Y,Y1=0 W ! Q
 I $E(IOST,1)'["C",$Y>64 W @IOF Q
 Q
VER Q:X["^"  I $D(^DPT(DFN,.361)) S Z=$P(^(.361),"^",1) W !,?10,"***ELIGIBILITY ",$S(Z="P":"PENDING VERIFICATION",Z="R":"PENDING RE-VERIFICATION",Z="V":"VERIFIED",1:"NOT VERIFIED"),"***",! Q
 W !!,?10,"***ELIGIBILITY NOT VERIFIED***",! Q
 ;
EN D LK I Y>0 D UP I Y>0 S DR="0:99",DIC="^DVB(395.5,",DA=DFN D VER,EN^DIQ G EN
 G EX
