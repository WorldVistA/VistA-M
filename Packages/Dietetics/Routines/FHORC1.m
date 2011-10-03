FHORC1 ; HISC/REL - Review Active Consults ;4/26/93  14:48 
 ;;5.5;DIETETICS;;Jan 28, 2005
E1 R !!,"Select CLINICIAN (or ALL): ",X:DTIME G:'$T!("^"[X) KIL D:X="all" TR^FH I X="ALL" S FHDZ=0
 E  K DIC S DIC="^VA(200,",DIC(0)="QEM" D ^DIC G:Y<1 E1 S FHDZ=+Y
E2 W ! K IOP,%ZIS S %ZIS("A")="Select LIST PRINTER: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q0^FHORC1",FHLST="FHDZ" D EN2^FH G:'FHDZ KIL G E1
 U IO D Q0 D ^%ZISC K %ZIS,IOP G KIL:'FHDZ,E1
Q0 ; Display Active Consults
 W:$E(IOST,1,2)="C-" @IOF W !?25,"A C T I V E   C O N S U L T S"
 I FHDZ S X=$P(^VA(200,FHDZ,0),"^",1) W !!?(80-$L(X)\2),X
 W !!,"Date/Time Ordered",?19,"Request",?31,"ID#",?40,"Patient",?62,$S(FHDZ:"Ward",1:"Clinician"),!
Q1 S FHDFN=0,X1=FHDZ I FHDZ G Q3
Q2 S X1=$O(^FHPT("ADRU",X1)) G:X1<1 Q10 S FHDFN=0
Q3 S FHDFN=$O(^FHPT("ADRU",X1,FHDFN)) G:FHDFN="" Q2:'FHDZ,Q10 S ADM=""
Q4 S ADM=$O(^FHPT("ADRU",X1,FHDFN,ADM)) G:ADM="" Q3 S DR=""
Q5 S DR=$O(^FHPT("ADRU",X1,FHDFN,ADM,DR)) G:DR="" Q4
 D PATNAME^FHOMUTL I DFN="" Q
 S Y=^FHPT(FHDFN,"A",ADM,"DR",DR,0)
 S REQ=$P(Y,"^",2),DTE=$P(Y,"^",1),DIET=$P(Y,"^",5)
 I '$D(^DGPM(ADM,0)) K ^FHPT("ADRU",X1,FHDFN) S $P(^FHPT(FHDFN,"A",ADM,"DR",DR,0),"^",8)="X" G Q5
 S Y=^DPT(DFN,0),PNAM=$P(Y,"^",1),FHWRD=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",8) D PID^FHDPA
 I FHDZ S WARD=$S(FHWRD:$P($G(^FH(119.6,FHWRD,0)),"^",1),1:"Discharged") I $P($G(^DGPM(ADM,0)),"^",17) S WARD="Discharged"
 I 'FHDZ S WARD=$P(^VA(200,DIET,0),"^",1)
 S REQ=$P($G(^FH(119.5,REQ,0)),"^",2)
 S DTP=DTE D DTP^FH
 W !,DTP,?19,REQ,?31,BID,?40,$E(PNAM,1,20),?62,$E(WARD,1,17) G Q5
Q10 I IOST?1"C-".E R !!,"Press RETURN to Continue ",X:DTIME Q:'$T!(X["^")
 W ! Q
KIL G KILL^XUSCLEAN
