FHPRW ;Hines OIFO/REL,RTK - List Dietetic Locations ;5/13/94  14:57 
 ;;5.5;DIETETICS;**12**;Jan 28, 2005;Build 3
 ; 10/24/07 BAY/KAM FH*5.5*12 CALL 214407 Display new Clinician Field
F1 R !!,"Select LOCATION (or ALL): ",X:DTIME G:'$T!("^"[X) KIL D:X="all" TR^FH I X="ALL" S WRD=0
 E  K DIC S DIC="^FH(119.6,",DIC(0)="EQM" D ^DIC K DIC G:Y<1 F1 S WRD=+Y
 I 'WRD W !!,"Verifying completeness of room-bed & ward assignments ..." D VER
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRW",FHLST="WRD" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Print Dietetic Ward Profile
 K ^TMP($J) D NOW^%DTC S NOW=%,PG=0 I WRD S K1=WRD D Q2 W ! Q
 F NX=0:0 S NX=$O(^FH(119.6,NX)) Q:NX<1  S X=$G(^(NX,0)),P0=$P(X,"^",4),P0=$S(P0<1:99,P0<10:"0"_P0,1:P0),WRDN=$P(X,"^",1),^TMP($J,"FHW",P0_"~"_WRDN)=NX
 S NX="" F  S NX=$O(^TMP($J,"FHW",NX)) Q:NX=""  S K1=+$G(^(NX)) I K1 D Q2
 W ! Q
Q2 S X=^FH(119.6,K1,0),NODE1=$G(^FH(119.6,K1,1)) D BLD,HDR
 W !!,"Print Order:",?22,$P(X,"^",4)
 W !,"Type of Location:",?22,$S($P(X,U,3)="O":"OUTPATIENT",1:"INPATIENT")
 ;
 ;10/24/07 BAY/KAM *12 214407 Print new Clinician Multiple field
 N C1 S C1=""
 F  S C1=$O(^FH(119.6,K1,2,C1)) Q:C1=""  D
 .  S Z=$G(^FH(119.6,K1,2,C1,0)) I Z W !,"Assigned Clinician(s):",?22,$P($G(^VA(200,Z,0)),"^",1)
 ;
 W !,"Tray Assembly:",?22 S Z=$P(X,"^",5) I Z W $P($G(^FH(119.72,Z,0)),"^",1) S Z=$P(X,"^",17) S:Z="" Z=100 W "   (",Z,"%)"
 W !,"Cafeteria:",?22 S Z=$P(X,"^",6) I Z W $P($G(^FH(119.72,Z,0)),"^",1) S Z=$P(X,"^",18) S:Z="" Z=100 W "   (",Z,"%)"
 W !,"Dining Room:",?22 S Z=$P(X,"^",7) I Z W "Yes" S Z=$P(X,"^",19) S:Z="" Z=100 W "   (",Z,"%)"
 W !,"Supplemental Fdgs.:",?22 S Z=$P(X,"^",9) I Z W $P($G(^FH(119.74,Z,0)),"^",1)
 W !,"Diet Communication:",?22 S Z=$P(X,"^",8) I Z W $P($G(^FH(119.73,Z,0)),"^",1)
 W !!,"Admission Diet:",?22 S Z=$P(X,"^",15) I Z W $P($G(^FH(111,Z,0)),"^",1)
 E  I $P(X,"^",16)="Y" W "NO ORDER"
 W !!,"Review Frequencies:"
 W !!?5,"NPO's:" S Z=$P(X,"^",11) W:Z ?19,$J(Z,3,0)," days"
 W ?45,"Admit Status:" S Z=$P(X,"^",14) W:Z ?59,$J(Z,3,0)," days"
 W !?5,"Tubefeedings:" S Z=$P(X,"^",12) W:Z ?19,$J(Z,3,0)," days"
 W ?45,"Supp. Fdgs.:" S Z=$P(X,"^",13) W:Z ?59,$J(Z,3,0)," days"
 W !!?5,"Status I:" S Z=$P(X,"^",20) W:Z ?19,$J(Z,3,0)," days"
 W ?45,"Status III:" S Z=$P(X,"^",22) W:Z ?59,$J(Z,3,0)," days"
 W !?5,"Status II:" S Z=$P(X,"^",21) W:Z ?19,$J(Z,3,0)," days"
 W ?45,"Status IV:" S Z=$P(X,"^",23) W:Z ?59,$J(Z,3,0)," days"
 S FHY=$P(X,"^",24) W !!,"Bulk Nourishment Orders:",!
 K P S N=0,NM="" F  S NM=$O(^TMP($J,"B",NM)) Q:NM=""  S N=N+1,P(N)=$J(^(NM),3,0)_" "_$P(NM,"~",1)
 I N S (Z,K)=N+1\2 F LL=1:1:Z W !?5,P(LL) S K=K+1 I $D(P(K)) W ?45,P(K)
 W !!,"Room-Beds Assigned:",!
 K P S N=0,NM="" F  S NM=$O(^TMP($J,"R",NM)) Q:NM=""  S N=N+1,P(N)=$P(NM,"~",1)
 I N S Z=N+3\4 S K(22)=Z,K(39)=2*Z,K(54)=3*Z F LL=1:1:Z W !?5,P(LL) F MM=22,39,54 S K(MM)=K(MM)+1 I $D(P(K(MM))) W ?MM,P(K(MM))
 W !!,"Default MAS Wards:",!
 K P S N=0,NM="" F  S NM=$O(^TMP($J,"W",NM)) Q:NM=""  S N=N+1,P(N)=$P(NM,"~",1)
 I N S (Z,K)=N+1\2 F LL=1:1:Z W !?5,P(LL) S K=K+1 I $D(P(K)) W ?45,P(K)
 W !!,"Print Cafeteria on Tray Tickets: ",$S(FHY="Y":"YES",1:"NO")
 S FHOL=$P(NODE1,U,1),FHOLFIL=$S(FHOL["SC(":44,FHOL["DIC(42":42,1:0)
 S FHOLNM="" I FHOLFIL D
 .S FHOLIEN=$P(FHOL,";",1)
 .I FHOLFIL=42 S FHOLNM=$P($G(^DIC(42,FHOLIEN,0)),U,1)
 .I FHOLFIL=44 S FHOLNM=$P($G(^SC(FHOLIEN,0)),U,1)
 .W !!,"Outpatient Location: ",FHOLNM,!
 W !,"Maximum # of Days to Schedule Recurring Meal: ",$P(NODE1,U,2)
 W !,"Number of Days  for Review of Recurring Meal: ",$P(NODE1,U,3)
 W !!,"Non-VA Facility? ",$S($P(NODE1,U,4)="Y":"YES",1:"NO")
 W ! Q
BLD ; Build temp files
 K ^TMP($J,"B"),^TMP($J,"R"),^TMP($J,"W")
 F LL=0:0 S LL=$O(^FH(119.6,K1,"BN",LL)) Q:LL<1  S Y=^(LL,0) D B1
 F LL=0:0 S LL=$O(^FH(119.6,K1,"W",LL)) Q:LL<1  S Y=^(LL,0) D B2
 F LL=0:0 S LL=$O(^FH(119.6,K1,"R",LL)) Q:LL<1  S Y=^(LL,0) D B3
 Q
B1 S N=+Y,Q=$P(Y,"^",2) Q:'N!('Q)  S N=$P($G(^FH(118,N,0)),"^",1) Q:N=""  S ^TMP($J,"B",N_"~"_(+Y))=Q Q
B2 S N=$P($G(^DIC(42,+Y,0)),"^",1) Q:N=""  S ^TMP($J,"W",N_"~"_(+Y))="" Q
B3 S N=$P($G(^DG(405.4,+Y,0)),"^",1) Q:N=""  S ^TMP($J,"R",N_"~"_(+Y))="" Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1,DTP=NOW D DTP^FH W !,$E(DTP,1,9),?19,"D I E T E T I C   L O C A T I O N   P R O F I L E",?73,"Page ",PG
 S Y=$P(X,"^",1) W !!?(78-$L(Y)\2),Y
 W !,"-------------------------------------------------------------------------------",! Q
VER ; Verify completeness of data base
 F LL=0:0 S LL=$O(^DG(405.4,LL)) Q:LL'>0  I '$D(^FH(119.6,"AR",LL)) W !,"Room ",$P(^DG(405.4,LL,0),"^",1)," not assigned to any Dietetic Ward"
 F LL=0:0 S LL=$O(^DIC(42,LL)) Q:LL'>0  I $G(^DIC(42,LL,"ORDER")),'$D(^FH(119.6,"AW",LL)) W !,"MAS Ward ",$P(^DIC(42,LL,0),"^",1)," not assigned to any Dietetics Ward"
 Q
KIL K ^TMP($J) G KILL^XUSCLEAN
