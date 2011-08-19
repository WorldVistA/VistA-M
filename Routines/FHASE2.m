FHASE2 ; HISC/REL - Patient Encounter Inquiry ;4/27/93  10:08
 ;;5.5;DIETETICS;;Jan 28, 2005
 S ALL=1 D ^FHDPA G:'DFN KIL
 I $P($G(^DPT(DFN,.35)),"^",1) W *7,!!?5,"  [ Patient has expired. ]"
 I '$D(^FHEN("AP",DFN)) W !!,"No Encounters on file for this patient." G FHASE2
 K %DT S %DT="AEPX",%DT("A")="Display Encounters Since: ",%DT(0)="-NOW" W ! D ^%DT K %DT S:$D(DTOUT) Y=0 G:Y<1 KIL S DTE=Y
 K IOP S %ZIS="MQ",%ZIS("B")="HOME" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHASE2",FHLST="DFN^PID^DTE" D EN2^FH G FHASE2
 U IO D Q1 D ^%ZISC K %ZIS,IOP G FHASE2
Q1 ; Display Encounters
 S Y=$G(^DPT(DFN,0)),NAM=$P(Y,"^",1),N1=0,QT="^" D NOW^%DTC S DT=%\1,PG=0,N1=0,QT=""
 S DTP=DTE D DTP^FH S STRT=DTP D HDR
 F DTE=DTE-.000001:0 S DTE=$O(^FHEN("AP",DFN,DTE)) Q:DTE<1  F ASN=0:0 S ASN=$O(^FHEN("AP",DFN,DTE,ASN)) Q:ASN<1  D:(IOSL-$Y)<6 HDR G:QT="^" QT D LST S N1=N1+1
 I 'N1 W !!,"No Encounters recorded since ",STRT
QT W ! Q
LST S X0=$G(^FHEN(ASN,0)),X1=$G(^FHEN(ASN,"P",DFN,0))
 S DTP=$P(X0,"^",2) D DTP^FH W !!,$E(DTP,1,9),"  " S Y=$P(X0,"^",4),Y=$P($G(^FH(115.6,+Y,0)),"^",1) W Y I $P(X0,"^",7)="F" W " (FU)"
 S Y=$P(X0,"^",3),Y=$P($G(^VA(200,+Y,0)),"^",1) W !,"Clinician: ",Y
 S Y=$P(X0,"^",5) I Y S Y=$P($G(^SC(+Y,0)),"^",1) I Y'="" W ?40,"Location: ",Y
 S Y=$P(X0,"^",11) I Y'="" W !?11,Y
 S Y=$P(X0,"^",9) W !?11,$S(Y="G":"Group",1:"Individual") S Y=$P(X1,"^",3) I Y W ", ",Y," collateral" W:Y>1 "s"
 S Y=$P(X1,"^",4) W:Y'="" !?11,Y
 S DTP=$P(X0,"^",14) I DTP D DTP^FH W !,"Entered  : ",DTP S Y=$P(X0,"^",13),Y=$P($G(^VA(200,+Y,0)),"^",1) W:Y'="" "  By: ",Y
 S DTP=$P(X0,"^",15) I DTP D DTP^FH W !,"Reviewed : ",DTP S Y=$P(X0,"^",16),Y=$P($G(^VA(200,+Y,0)),"^",1) W:Y'="" "  By: ",Y
 Q
HDR ; Print Header
 S QT="" G:IOST'?1"C".E H1
 I PG R !!,"Press RETURN to continue  ",QT:DTIME S:'$T QT="^" Q:QT="^"
H1 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S DTP=DT D DTP^FH S DTP=$E(DTP,1,9),PG=PG+1
 W !,DTP,?13,"P A T I E N T   D I E T E T I C   E N C O U N T E R S",?73,"Page ",PG
 W !!,PID,?18,NAM Q
KIL G KILL^XUSCLEAN
